use actix_web::{delete, get, post, web, HttpResponse, Responder};
use surrealdb::Surreal;

use crate::models::{Guitar, Image};

pub fn config(cfg: &mut web::ServiceConfig) {
    cfg.service(health)
        .service(list_guitars)
        .service(get_guitar_by_id)
        .service(get_guitar_by_slug)
        .service(delete_guitar)
        .service(delete_guitar_post_redirect)
        .service(list_images);
}

#[get("/health")]
async fn health() -> impl Responder {
    HttpResponse::Ok().json(serde_json::json!({"ok": true}))
}

#[delete("/api/guitars/{id}")]
async fn delete_guitar(
    db: web::Data<Surreal<surrealdb::engine::remote::http::Client>>,
    path: web::Path<String>,
) -> impl Responder {
    let id_str = path.into_inner();
    let rid = if id_str.contains(':') {
        id_str
    } else {
        format!("guitars:{id_str}")
    };

    // DELETE FROM guitars WHERE id = rid
    let res: surrealdb::Result<Vec<serde_json::Value>> = db.delete(rid.as_str()).await;
    match res {
        Ok(_) => HttpResponse::NoContent().finish(),
        Err(e) => {
            HttpResponse::InternalServerError().json(serde_json::json!({"error": e.to_string()}))
        }
    }
}

// Convenience endpoint for HTML forms (since forms cannot send DELETE)
#[post("/api/guitars/{id}/delete")]
async fn delete_guitar_post_redirect(
    db: web::Data<Surreal<surrealdb::engine::remote::http::Client>>,
    path: web::Path<String>,
) -> impl Responder {
    let id_str = path.into_inner();
    let rid = if id_str.contains(':') {
        id_str
    } else {
        format!("guitars:{id_str}")
    };

    let _: surrealdb::Result<Vec<serde_json::Value>> = db.delete(rid.as_str()).await;
    HttpResponse::SeeOther()
        .append_header(("Location", "/guitars"))
        .finish()
}

#[get("/api/guitars")]
async fn list_guitars(
    db: web::Data<Surreal<surrealdb::engine::remote::http::Client>>,
) -> impl Responder {
    // SELECT * FROM guitars
    let res: surrealdb::Result<Vec<Guitar>> = db.select("guitars").await;
    match res {
        Ok(rows) => HttpResponse::Ok().json(rows),
        Err(e) => {
            HttpResponse::InternalServerError().json(serde_json::json!({"error": e.to_string()}))
        }
    }
}

#[get("/api/guitars/{id}")]
async fn get_guitar_by_id(
    db: web::Data<Surreal<surrealdb::engine::remote::http::Client>>,
    path: web::Path<String>,
) -> impl Responder {
    // Accept either "guitars:abc123" or just "abc123"
    let id_str = path.into_inner();
    let rid = if id_str.contains(':') {
        id_str
    } else {
        format!("guitars:{id_str}")
    };

    // Use db.select with the record ID
    let res: surrealdb::Result<Vec<Guitar>> = db.select(rid.as_str()).await;
    match res {
        Ok(rows) if !rows.is_empty() => HttpResponse::Ok().json(rows[0].clone()),
        Ok(_) => {
            HttpResponse::NotFound().json(serde_json::json!({"error": "not found", "id": rid}))
        }
        Err(e) => {
            HttpResponse::InternalServerError().json(serde_json::json!({"error": e.to_string()}))
        }
    }
}

#[get("/api/guitars/slug/{slug}")]
async fn get_guitar_by_slug(
    db: web::Data<Surreal<surrealdb::engine::remote::http::Client>>,
    path: web::Path<String>,
) -> impl Responder {
    let slug = path.into_inner();

    // Since we can't query by slug due to DB issues, get all guitars and filter in Rust
    let res: surrealdb::Result<Vec<Guitar>> = db.select("guitars").await;

    match res {
        Ok(rows) => {
            // Find guitar by generated slug
            if let Some(guitar) = rows.into_iter().find(|g| g.get_slug() == slug) {
                HttpResponse::Ok().json(guitar)
            } else {
                HttpResponse::NotFound().json(serde_json::json!({"error": "not found", "slug": slug}))
            }
        }
        Err(e) => {
            HttpResponse::InternalServerError().json(serde_json::json!({"error": e.to_string()}))
        }
    }
}

#[get("/api/images")]
async fn list_images(
    db: web::Data<Surreal<surrealdb::engine::remote::http::Client>>,
    query: web::Query<std::collections::HashMap<String, String>>,
) -> impl Responder {
    let limit = query
        .get("limit")
        .and_then(|s| s.parse::<usize>().ok())
        .unwrap_or(60);

    let cursor = query.get("cursor");

    // SELECT * FROM images LIMIT limit
    let res: surrealdb::Result<Vec<Image>> = db.select("images").await;
    match res {
        Ok(mut rows) => {
            // Simple cursor-based pagination
            if let Some(cursor_id) = cursor {
                if let Some(pos) = rows.iter().position(|img| {
                    img.id.as_ref().map(|id| id.to_string()) == Some(cursor_id.clone())
                }) {
                    rows = rows.into_iter().skip(pos + 1).collect();
                }
            }

            // Limit results
            rows.truncate(limit);
            HttpResponse::Ok().json(rows)
        }
        Err(e) => {
            HttpResponse::InternalServerError().json(serde_json::json!({"error": e.to_string()}))
        }
    }
}
