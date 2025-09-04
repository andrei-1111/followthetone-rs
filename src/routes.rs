use actix_web::{get, post, web, HttpResponse, Responder};
use sqlx::{postgres::PgRow, PgPool, Row, QueryBuilder};

use crate::models::*;

pub fn config(cfg: &mut web::ServiceConfig) {
    cfg.service(health)
        .service(list_brands)
        .service(list_gear)
        .service(get_gear_by_slug)
        .service(create_gear)
        .route("/", web::get().to(root));
}

async fn root() -> impl Responder {
    HttpResponse::Ok().json(serde_json::json!({"ok": true, "service": "gear_api"}))
}

#[get("/health")]
async fn health() -> impl Responder { HttpResponse::Ok().body("ok") }

#[get("/brands")]
async fn list_brands(db: web::Data<PgPool>) -> impl Responder {
    let rows = sqlx::query_as::<_, Brand>(
        "SELECT id, name, country, founded_year FROM brands ORDER BY name"
    ).fetch_all(db.get_ref()).await;

    match rows { Ok(data) => HttpResponse::Ok().json(data), Err(e) => err(e) }
}

#[get("/gear")] // /gear?q=strat&gear_type=guitar&brand=Fender&page=1&page_size=20
async fn list_gear(db: web::Data<PgPool>, query: web::Query<GearQuery>) -> impl Responder {
    let q = query.into_inner();
    let mut qb: QueryBuilder<'_, sqlx::Postgres> = QueryBuilder::new(
        "SELECT g.id, g.brand_id, g.category_id, g.name, g.slug, g.type AS gear_type, g.year_start, g.year_end, g.description FROM gear g"
    );

    let mut has_where = false;
    let mut push_where = |qb: &mut QueryBuilder<'_, sqlx::Postgres>| {
        if !has_where { qb.push(" WHERE "); has_where = true; } else { qb.push(" AND "); }
    };

    if let Some(gt) = q.gear_type.as_deref() {
        push_where(&mut qb);
        qb.push(" g.type = ").push_bind(gt);
    }

    if let Some(brand) = q.brand.as_deref() {
        push_where(&mut qb);
        qb.push(" g.brand_id IN (SELECT id FROM brands WHERE name ILIKE ")
            .push_bind(brand)
            .push(")");
    }

    if let Some(term) = q.q.as_deref() {
        push_where(&mut qb);
        qb.push(" g.name ILIKE ").push_bind(format!("%{}%", term));
    }

    qb.push(" ORDER BY g.name ASC ");

    let page = q.page.unwrap_or(1).max(1);
    let size = q.page_size.unwrap_or(20).clamp(1, 200);
    let offset = (page - 1) * size;
    qb.push(" LIMIT ").push_bind(size).push(" OFFSET ").push_bind(offset);

    let query = qb.build_query_as::<Gear>();

    match query.fetch_all(db.get_ref()).await { Ok(data) => HttpResponse::Ok().json(data), Err(e) => err(e) }
}

#[get("/gear/{slug}")]
async fn get_gear_by_slug(db: web::Data<PgPool>, path: web::Path<String>) -> impl Responder {
    let slug = path.into_inner();
    let row = sqlx::query_as::<_, Gear>(
        "SELECT id, brand_id, category_id, name, slug, type AS gear_type, year_start, year_end, description FROM gear WHERE slug = $1"
    ).bind(slug)
     .fetch_optional(db.get_ref()).await;

    match row {
        Ok(Some(g)) => HttpResponse::Ok().json(g),
        Ok(None) => HttpResponse::NotFound().json(serde_json::json!({"error":"Not found"})),
        Err(e) => err(e),
    }
}

#[post("/gear")] // admin insert: brand/category by name
async fn create_gear(db: web::Data<PgPool>, body: web::Json<NewGear>) -> impl Responder {
    let ng = body.into_inner();

    let rec = sqlx::query_as::<_, Gear>(
        r#"
        INSERT INTO gear (brand_id, category_id, name, slug, type, year_start, year_end, description)
        VALUES (
            (SELECT id FROM brands WHERE name = $1),
            (SELECT id FROM categories WHERE name = $2),
            $3, $4, $5::gear_type, $6, $7, $8
        )
        RETURNING id, brand_id, category_id, name, slug, type AS gear_type, year_start, year_end, description
        "#
    )
    .bind(ng.brand)
    .bind(ng.category)
    .bind(ng.name)
    .bind(ng.slug)
    .bind(ng.gear_type)
    .bind(ng.year_start)
    .bind(ng.year_end)
    .bind(ng.description)
    .fetch_one(db.get_ref())
    .await;

    match rec { Ok(g) => HttpResponse::Created().json(g), Err(e) => err(e) }
}

fn err<E: std::fmt::Display>(e: E) -> HttpResponse {
    log::error!("{}", e);
    HttpResponse::InternalServerError().json(serde_json::json!({"error": e.to_string()}))
}
