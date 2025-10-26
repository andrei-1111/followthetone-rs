use gear_api::routes::ApiDoc;
use utoipa::OpenApi;

fn main() {
    let openapi = ApiDoc::openapi();
    let json = serde_json::to_string_pretty(&openapi).unwrap();

    // Create docs directory if it doesn't exist
    std::fs::create_dir_all("docs").unwrap();

    // Write the OpenAPI specification to a JSON file
    std::fs::write("docs/api-documentation.json", json).unwrap();

    println!("✅ API documentation generated successfully!");
    println!("📄 Documentation saved to: docs/api-documentation.json");
    println!("🌐 Swagger UI available at: http://localhost:8080/swagger-ui/");
    println!("📋 OpenAPI JSON available at: http://localhost:8080/api-docs/openapi.json");
}
