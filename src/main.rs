use actix_cors::Cors;
use actix_files::Files;
use actix_web::{middleware::Logger, web, App, HttpServer};
use leptos::*;
use leptos_actix::{generate_route_list, LeptosRoutes};
use surrealdb::opt::auth::Root;
use surrealdb::Surreal;

use gear_api::App;

mod config;
mod models;
mod routes;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenvy::dotenv().ok();
    env_logger::init();

    let cfg = config::AppConfig::from_env();

    // Debug: Print the SurrealDB URL
    println!("🔍 SurrealDB URL: '{}'", cfg.surreal_url);

    // --- SurrealDB client (HTTPS) ---
    let db = Surreal::new::<surrealdb::engine::remote::http::Https>(&cfg.surreal_url)
        .await
        .expect("connect Surreal"); // connect() :contentReference[oaicite:3]{index=3}
    db.signin(Root {
        username: &cfg.surreal_user,
        password: &cfg.surreal_pass,
    })
    .await
    .expect("signin");
    db.use_ns(&cfg.surreal_ns)
        .use_db(&cfg.surreal_db)
        .await
        .expect("use ns/db"); // use_ns/use_db before queries :contentReference[oaicite:4]{index=4}

    // Leptos configuration
    let conf = get_configuration(None).await.unwrap();
    let leptos_options = conf.leptos_options;
    let _addr = leptos_options.site_addr;
    let routes = generate_route_list(App);

    HttpServer::new(move || {
        let cors = Cors::permissive();
        let leptos_options = &leptos_options;
        let site_root = &leptos_options.site_root;

        App::new()
            .wrap(Logger::default())
            .wrap(cors)
            .app_data(web::Data::new(db.clone()))
            .configure(routes::config)
            .service(Files::new("/pkg", format!("{site_root}/pkg")))
            .service(Files::new("/assets", site_root))
            .leptos_routes(leptos_options.to_owned(), routes.clone(), App)
            .app_data(web::Data::new(leptos_options.to_owned()))
    })
    .bind((cfg.host.as_str(), cfg.port))?
    .run()
    .await
}
