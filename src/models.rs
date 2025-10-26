use serde::{Deserialize, Serialize};
use serde_json::json;
use surrealdb::sql::Thing; // record id type "table:id"
use utoipa::ToSchema;

#[derive(Serialize, Deserialize, Debug, Clone, ToSchema)]
#[schema(example = json!({
    "id": "guitars:123",
    "brand": "Banker",
    "model": "58' Spec V",
    "slug": "banker-58-spec-v",
    "display_title": "Banker 58' Spec V",
    "formatted_price": "$4,699.00",
    "main_image": "https://example.com/hero.jpg",
    "has_images": true,
    "image_count": 3,
    "condition_color": "green",
    "status_color": "success",
    "hero_image_url": "https://example.com/hero.jpg",
    "image_gallery": ["https://example.com/image1.jpg", "https://example.com/image2.jpg"],
    "image_source": "scraped",
    "condition": "Excellent +",
    "status": "Available",
    "production_year": 2024,
    "spec_version_year": 1958,
    "price_cents": 469900,
    "price_currency": "USD",
    "body_style": "V",
    "line": "",
    "variant": "",
    "year_reference": "1958",
    "weight": "",
    "serial_number": ""
}))]
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
    // New fields for image support
    #[serde(default)]
    pub hero_image_url: Option<String>,
    #[serde(default)]
    pub image_gallery: Option<Vec<String>>,
    #[serde(default)]
    pub image_source: Option<String>,
    #[serde(default)]
    pub condition: Option<String>,
    #[serde(default)]
    pub status: Option<String>,
    #[serde(default)]
    pub production_year: Option<i32>,
    #[serde(default)]
    pub spec_version_year: Option<i32>,
    // External source fields
    #[serde(default)]
    pub external_source: Option<String>,
    #[serde(default)]
    pub external_id: Option<String>,
    #[serde(default)]
    pub listing_url: Option<String>,
    #[serde(default)]
    pub shop_name: Option<String>,
    #[serde(default)]
    pub shop_slug: Option<String>,
    // Legacy image field
    #[serde(default)]
    pub hero_url: Option<String>,
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

    /// Get the main image URL with fallback strategy
    pub fn get_main_image(&self) -> Option<String> {
        self.hero_image_url
            .clone()
            .or_else(|| self.hero_url.clone())
    }

    /// Get formatted price for display
    pub fn get_formatted_price(&self) -> String {
        if self.price_cents > 0 {
            let dollars = self.price_cents as f64 / 100.0;
            format!("${:.2}", dollars)
        } else {
            "Price on request".to_string()
        }
    }

    /// Get display title for the guitar
    pub fn get_display_title(&self) -> String {
        format!("{} {}", self.brand, self.model)
    }

    /// Check if guitar has images
    pub fn has_images(&self) -> bool {
        self.hero_image_url.is_some()
            || self.hero_url.is_some()
            || self.image_gallery.as_ref().map_or(false, |gallery| !gallery.is_empty())
    }

    /// Get image gallery count
    pub fn get_image_count(&self) -> usize {
        self.image_gallery.as_ref().map_or(0, |gallery| gallery.len())
    }

    /// Get condition color for frontend styling
    pub fn get_condition_color(&self) -> &'static str {
        match self.condition.as_deref() {
            Some("Excellent +") | Some("Excellent") => "green",
            Some("Good") => "yellow",
            Some("Fair") | Some("Poor") => "red",
            _ => "gray",
        }
    }

    /// Get status color for frontend styling
    pub fn get_status_color(&self) -> &'static str {
        match self.status.as_deref() {
            Some("Available") => "success",
            Some("Sold") => "danger",
            Some("On Hold") => "warning",
            Some("Pending") => "info",
            _ => "secondary",
        }
    }
}

#[derive(Serialize, Deserialize, Debug, Clone, ToSchema)]
pub struct Image {
    pub id: Option<Thing>, // Surreal record id, e.g. images:abc...
    pub src: String,
    pub alt: Option<String>,
    pub w: i32,
    pub h: i32,
    #[serde(default)]
    pub guitar_id: Option<String>, // Reference to guitar if applicable
}

#[derive(Serialize, Deserialize, Debug, Clone, ToSchema)]
#[schema(example = json!({
    "hero_image_url": "https://example.com/hero.jpg",
    "image_gallery": [
        "https://example.com/image1.jpg",
        "https://example.com/image2.jpg"
    ],
    "image_source": "scraped",
    "condition": "Excellent +",
    "status": "Available"
}))]
pub struct ImageUpdateRequest {
    pub hero_image_url: Option<String>,
    pub image_gallery: Option<Vec<String>>,
    pub image_source: Option<String>,
    pub condition: Option<String>,
    pub status: Option<String>,
}

#[derive(Serialize, Deserialize, Debug, Clone, ToSchema)]
#[schema(example = json!({
    "error": "Guitar not found",
    "status": "error"
}))]
pub struct ErrorResponse {
    pub error: String,
    pub status: String,
}
