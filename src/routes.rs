use actix_web::{get, web, HttpResponse, Responder};
use surrealdb::Surreal;

use crate::models::Guitar;

pub fn config(cfg: &mut web::ServiceConfig) {
    cfg.service(health)
        .service(list_guitars)
        .service(get_guitar_by_id);
}

#[get("/health")]
async fn health() -> impl Responder {
    HttpResponse::Ok().json(serde_json::json!({"ok": true}))
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

    // SELECT * FROM guitars:<id>
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
