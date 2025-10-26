use actix_web::{delete, get, post, put, web, HttpResponse, Responder};
use surrealdb::Surreal;
use serde_json::json;
use utoipa::OpenApi;
use utoipa_swagger_ui::SwaggerUi;

use crate::models::{Guitar, Image, ImageUpdateRequest, ErrorResponse};

#[derive(OpenApi)]
#[openapi(
    paths(
        health,
        list_guitars,
        get_guitar_by_id,
        get_guitar_by_slug,
        update_guitar_images,
        get_api_schema
    ),
    components(
        schemas(Guitar, Image, ImageUpdateRequest, ErrorResponse)
    ),
    tags(
        (name = "guitars", description = "Guitar management endpoints"),
        (name = "health", description = "Health check endpoints"),
        (name = "docs", description = "API documentation endpoints")
    ),
    info(
        title = "Guitar API",
        version = "1.0.0",
        description = "API for managing guitar data with image support"
    )
)]
pub struct ApiDoc;

pub fn config(cfg: &mut web::ServiceConfig) {
    cfg.service(
        SwaggerUi::new("/swagger-ui/{_:.*}")
            .url("/api-docs/openapi.json", ApiDoc::openapi())
    )
    .service(health)
    .service(list_guitars)
    .service(get_guitar_by_id)
    .service(get_guitar_by_slug)
    .service(delete_guitar)
    .service(delete_guitar_post_redirect)
    .service(list_images)
    .service(update_guitar_images)
    .service(get_api_schema);
}

#[utoipa::path(
    get,
    path = "/health",
    tag = "health",
    responses(
        (status = 200, description = "Health check successful", body = serde_json::Value)
    )
)]
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

#[utoipa::path(
    get,
    path = "/api/guitars",
    tag = "guitars",
    responses(
        (status = 200, description = "List of guitars with enhanced data", body = Vec<serde_json::Value>),
        (status = 500, description = "Internal server error", body = ErrorResponse)
    )
)]
#[get("/api/guitars")]
async fn list_guitars(
    db: web::Data<Surreal<surrealdb::engine::remote::http::Client>>,
) -> impl Responder {
    // SELECT * FROM guitars
    let res: surrealdb::Result<Vec<Guitar>> = db.select("guitars").await;
    match res {
        Ok(rows) => {
            // Transform guitars to include generated slugs and helper data for frontend
            let guitars_with_enhanced_data: Vec<serde_json::Value> = rows
                .into_iter()
                .map(|guitar| {
                    let generated_slug = guitar.get_slug();
                    let mut guitar_json = serde_json::to_value(&guitar).unwrap_or_default();
                    if let serde_json::Value::Object(ref mut map) = guitar_json {
                        map.insert("slug".to_string(), serde_json::Value::String(generated_slug));
                        map.insert("display_title".to_string(), serde_json::Value::String(guitar.get_display_title()));
                        map.insert("formatted_price".to_string(), serde_json::Value::String(guitar.get_formatted_price()));
                        map.insert("main_image".to_string(), serde_json::Value::String(guitar.get_main_image().unwrap_or_default()));
                        map.insert("has_images".to_string(), serde_json::Value::Bool(guitar.has_images()));
                        map.insert("image_count".to_string(), serde_json::Value::Number(serde_json::Number::from(guitar.get_image_count())));
                        map.insert("condition_color".to_string(), serde_json::Value::String(guitar.get_condition_color().to_string()));
                        map.insert("status_color".to_string(), serde_json::Value::String(guitar.get_status_color().to_string()));
                    }
                    guitar_json
                })
                .collect();
            HttpResponse::Ok().json(guitars_with_enhanced_data)
        }
        Err(e) => {
            HttpResponse::InternalServerError().json(serde_json::json!({"error": e.to_string()}))
        }
    }
}

#[utoipa::path(
    get,
    path = "/api/guitars/{id}",
    tag = "guitars",
    params(
        ("id" = String, Path, description = "Guitar ID (e.g., 'guitars:123' or '123')")
    ),
    responses(
        (status = 200, description = "Guitar found", body = serde_json::Value),
        (status = 404, description = "Guitar not found", body = ErrorResponse),
        (status = 500, description = "Internal server error", body = ErrorResponse)
    )
)]
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
        Ok(rows) if !rows.is_empty() => {
            let guitar = &rows[0];
            let mut guitar_json = serde_json::to_value(guitar).unwrap_or_default();
            if let serde_json::Value::Object(ref mut map) = guitar_json {
                map.insert("slug".to_string(), serde_json::Value::String(guitar.get_slug()));
                map.insert("display_title".to_string(), serde_json::Value::String(guitar.get_display_title()));
                map.insert("formatted_price".to_string(), serde_json::Value::String(guitar.get_formatted_price()));
                map.insert("main_image".to_string(), serde_json::Value::String(guitar.get_main_image().unwrap_or_default()));
                map.insert("has_images".to_string(), serde_json::Value::Bool(guitar.has_images()));
                map.insert("image_count".to_string(), serde_json::Value::Number(serde_json::Number::from(guitar.get_image_count())));
                map.insert("condition_color".to_string(), serde_json::Value::String(guitar.get_condition_color().to_string()));
                map.insert("status_color".to_string(), serde_json::Value::String(guitar.get_status_color().to_string()));
            }
            HttpResponse::Ok().json(guitar_json)
        }
        Ok(_) => {
            HttpResponse::NotFound().json(serde_json::json!({"error": "not found", "id": rid}))
        }
        Err(e) => {
            HttpResponse::InternalServerError().json(serde_json::json!({"error": e.to_string()}))
        }
    }
}

#[utoipa::path(
    get,
    path = "/api/guitars/slug/{slug}",
    tag = "guitars",
    params(
        ("slug" = String, Path, description = "Guitar slug (e.g., 'banker-58-spec-v')")
    ),
    responses(
        (status = 200, description = "Guitar found", body = serde_json::Value),
        (status = 404, description = "Guitar not found", body = ErrorResponse),
        (status = 500, description = "Internal server error", body = ErrorResponse)
    )
)]
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
                // Transform guitar to include generated slug and helper data for frontend
                let mut guitar_json = serde_json::to_value(&guitar).unwrap_or_default();
                if let serde_json::Value::Object(ref mut map) = guitar_json {
                    map.insert("slug".to_string(), serde_json::Value::String(guitar.get_slug()));
                    map.insert("display_title".to_string(), serde_json::Value::String(guitar.get_display_title()));
                    map.insert("formatted_price".to_string(), serde_json::Value::String(guitar.get_formatted_price()));
                    map.insert("main_image".to_string(), serde_json::Value::String(guitar.get_main_image().unwrap_or_default()));
                    map.insert("has_images".to_string(), serde_json::Value::Bool(guitar.has_images()));
                    map.insert("image_count".to_string(), serde_json::Value::Number(serde_json::Number::from(guitar.get_image_count())));
                    map.insert("condition_color".to_string(), serde_json::Value::String(guitar.get_condition_color().to_string()));
                    map.insert("status_color".to_string(), serde_json::Value::String(guitar.get_status_color().to_string()));
                }
                HttpResponse::Ok().json(guitar_json)
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

#[utoipa::path(
    put,
    path = "/api/guitars/{id}/images",
    tag = "guitars",
    params(
        ("id" = String, Path, description = "Guitar ID (e.g., 'guitars:123' or '123')")
    ),
    request_body = ImageUpdateRequest,
    responses(
        (status = 200, description = "Guitar images updated successfully", body = serde_json::Value),
        (status = 400, description = "Bad request - invalid image data", body = ErrorResponse),
        (status = 404, description = "Guitar not found", body = ErrorResponse),
        (status = 500, description = "Internal server error", body = ErrorResponse)
    )
)]
#[put("/api/guitars/{id}/images")]
async fn update_guitar_images(
    db: web::Data<Surreal<surrealdb::engine::remote::http::Client>>,
    path: web::Path<String>,
    body: web::Json<serde_json::Value>,
) -> impl Responder {
    let id_str = path.into_inner();
    let rid = if id_str.contains(':') {
        id_str
    } else {
        format!("guitars:{id_str}")
    };

    // Extract image data from request body
    let hero_image_url = body.get("hero_image_url").and_then(|v| v.as_str());
    let image_gallery = body.get("image_gallery").and_then(|v| v.as_array());
    let image_source = body.get("image_source").and_then(|v| v.as_str());
    let condition = body.get("condition").and_then(|v| v.as_str());
    let status = body.get("status").and_then(|v| v.as_str());

    // Build update query
    let mut update_fields = Vec::new();

    if let Some(hero_url) = hero_image_url {
        update_fields.push(format!("hero_image_url = \"{}\"", hero_url));
    }

    if let Some(gallery) = image_gallery {
        let gallery_strings: Vec<String> = gallery
            .iter()
            .filter_map(|v| v.as_str())
            .map(|s| format!("\"{}\"", s))
            .collect();
        if !gallery_strings.is_empty() {
            update_fields.push(format!("image_gallery = [{}]", gallery_strings.join(", ")));
        }
    }

    if let Some(source) = image_source {
        update_fields.push(format!("image_source = \"{}\"", source));
    }

    if let Some(cond) = condition {
        update_fields.push(format!("condition = \"{}\"", cond));
    }

    if let Some(stat) = status {
        update_fields.push(format!("status = \"{}\"", stat));
    }

    if update_fields.is_empty() {
        return HttpResponse::BadRequest().json(json!({
            "error": "No valid image fields provided"
        }));
    }

    update_fields.push("updated_at = time::now()".to_string());
    let update_query = format!("UPDATE {} SET {}", rid, update_fields.join(", "));

    // Execute update
    let res: surrealdb::Result<surrealdb::Response> = db.query(update_query).await;

    match res {
        Ok(_) => {
            // Return updated guitar data
            let guitar_res: surrealdb::Result<Vec<Guitar>> = db.select(rid.as_str()).await;
            match guitar_res {
                Ok(rows) if !rows.is_empty() => {
                    let guitar = &rows[0];
                    let mut guitar_json = serde_json::to_value(guitar).unwrap_or_default();
                    if let serde_json::Value::Object(ref mut map) = guitar_json {
                        map.insert("slug".to_string(), serde_json::Value::String(guitar.get_slug()));
                        map.insert("display_title".to_string(), serde_json::Value::String(guitar.get_display_title()));
                        map.insert("formatted_price".to_string(), serde_json::Value::String(guitar.get_formatted_price()));
                        map.insert("main_image".to_string(), serde_json::Value::String(guitar.get_main_image().unwrap_or_default()));
                        map.insert("has_images".to_string(), serde_json::Value::Bool(guitar.has_images()));
                        map.insert("image_count".to_string(), serde_json::Value::Number(serde_json::Number::from(guitar.get_image_count())));
                        map.insert("condition_color".to_string(), serde_json::Value::String(guitar.get_condition_color().to_string()));
                        map.insert("status_color".to_string(), serde_json::Value::String(guitar.get_status_color().to_string()));
                    }
                    HttpResponse::Ok().json(guitar_json)
                }
                _ => HttpResponse::NotFound().json(json!({"error": "Guitar not found after update"}))
            }
        }
        Err(e) => {
            HttpResponse::InternalServerError().json(json!({
                "error": "Failed to update guitar images",
                "details": e.to_string()
            }))
        }
    }
}

#[utoipa::path(
    get,
    path = "/api-docs/schema.json",
    tag = "docs",
    responses(
        (status = 200, description = "OpenAPI schema in JSON format", body = serde_json::Value)
    )
)]
#[get("/api-docs/schema.json")]
async fn get_api_schema() -> impl Responder {
    HttpResponse::Ok().json(ApiDoc::openapi())
}
