use actix_web::{delete, get, post, web, HttpResponse, Responder};
use surrealdb::Surreal;

use crate::models::Guitar;

pub fn config(cfg: &mut web::ServiceConfig) {
    cfg.service(health)
        .service(list_guitars)
        .service(get_guitar_by_id)
        .service(delete_guitar)
        .service(delete_guitar_post_redirect);
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
