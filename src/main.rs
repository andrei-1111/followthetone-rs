use actix_cors::Cors;
use actix_web::{middleware::Logger, web, App, HttpServer};
use surrealdb::opt::auth::Root;
use surrealdb::Surreal;

mod config;
mod models;
mod routes;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenvy::dotenv().ok();
    env_logger::init();

    let cfg = config::AppConfig::from_env();

    // --- SurrealDB client (HTTP) ---
    let db = Surreal::new::<surrealdb::engine::remote::http::Http>(&cfg.surreal_url).await
        .expect("connect Surreal");                                // connect() :contentReference[oaicite:3]{index=3}
    db.signin(Root {
        username: &cfg.surreal_user,
        password: &cfg.surreal_pass
    }).await.expect("signin");
    db.use_ns(&cfg.surreal_ns).use_db(&cfg.surreal_db).await
        .expect("use ns/db");                                      // use_ns/use_db before queries :contentReference[oaicite:4]{index=4}

    HttpServer::new(move || {
        let cors = Cors::permissive();
        App::new()
            .wrap(Logger::default())
            .wrap(cors)
            .app_data(web::Data::new(db.clone()))
            .configure(routes::config)
    })
    .bind((cfg.host.as_str(), cfg.port))?
    .run()
    .await
}
