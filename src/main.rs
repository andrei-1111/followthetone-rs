use actix_cors::Cors;
use actix_web::{middleware::Logger, web, App, HttpServer};
use sqlx::PgPool;

mod config;
mod models;
mod routes;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenvy::dotenv().ok();
    env_logger::init();

    let cfg = config::AppConfig::from_env();

    let pool = PgPool::connect(&cfg.database_url)
        .await
        .expect("Failed to connect to Postgres");

    log::info!("Connected to Postgres");

    HttpServer::new(move || {
        let cors = Cors::permissive(); // tighten for production

        App::new()
            .wrap(Logger::default())
            .wrap(cors)
            .app_data(web::Data::new(pool.clone()))
            .configure(routes::config)
    })
    .bind((cfg.host.as_str(), cfg.port))?
    .run()
    .await
}
