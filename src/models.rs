use serde::{Deserialize, Serialize};
use surrealdb::sql::Thing; // record id type "table:id"

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Guitar {
    pub id: Option<Thing>, // Surreal record id, e.g. guitars:abc...
    pub brand: String,
    pub model: String,
    #[serde(default)]
    pub slug: Option<String>, // URL-friendly identifier
    #[serde(default)]
    pub body_style: String,
    #[serde(default)]
    pub line: String,
    #[serde(default)]
    pub variant: String,
    #[serde(default)]
    pub year_reference: String,
    #[serde(default)]
    pub weight: String,
    #[serde(default)]
    pub price_cents: i64,
    #[serde(default)]
    pub price_currency: String,
    #[serde(default)]
    pub serial_number: String,
}

impl Guitar {
    /// Generate a slug for this guitar if one doesn't exist
    pub fn get_slug(&self) -> String {
        self.slug.clone().unwrap_or_else(|| {
            let brand = self.brand.to_lowercase().replace(" ", "-");
            let model = self.model.to_lowercase().replace(" ", "-");
            let year = self.year_reference.to_lowercase();
            format!("{}-{}-{}", brand, model, year)
        })
    }
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Image {
    pub id: Option<Thing>, // Surreal record id, e.g. images:abc...
    pub src: String,
    pub alt: Option<String>,
    pub w: i32,
    pub h: i32,
    #[serde(default)]
    pub guitar_id: Option<String>, // Reference to guitar if applicable
}
