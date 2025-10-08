use std::env;

pub struct AppConfig {
    pub host: String,
    pub port: u16,
    pub surreal_url: String,
    pub surreal_ns: String,
    pub surreal_db: String,
    pub surreal_user: String,
    pub surreal_pass: String,
}

impl AppConfig {
    pub fn from_env() -> Self {
        Self {
            host: env::var("HOST").unwrap_or_else(|_| "127.0.0.1".into()),
            port: env::var("PORT").ok().and_then(|v| v.parse().ok()).unwrap_or(8080),
            surreal_url: env::var("SURREAL_URL").expect("SURREAL_URL"),
            surreal_ns: env::var("SURREAL_NS").expect("SURREAL_NS"),
            surreal_db: env::var("SURREAL_DB").expect("SURREAL_DB"),
            surreal_user: env::var("SURREAL_USER").expect("SURREAL_USER"),
            surreal_pass: env::var("SURREAL_PASS").expect("SURREAL_PASS"),
        }
    }
}
