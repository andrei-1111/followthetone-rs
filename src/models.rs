use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, FromRow)]
pub struct Gear {
    pub id: i32,
    pub brand_id: Option<i32>,
    pub category_id: Option<i32>,
    pub name: String,
    pub slug: String,
    pub gear_type: String, // alias of SQL column "type"
    pub year_start: Option<i32>,
    pub year_end: Option<i32>,
    pub description: Option<String>,
}

#[derive(Debug, Serialize, FromRow)]
pub struct Brand { pub id: i32, pub name: String, pub country: Option<String>, pub founded_year: Option<i32> }

#[derive(Debug, Serialize, FromRow)]
pub struct Artist { pub id: i32, pub name: String, pub country: Option<String> }

#[derive(Debug, Deserialize)]
pub struct NewGear {
    pub name: String,
    pub slug: String,
    pub brand: Option<String>,      // brand name (lookup)
    pub category: Option<String>,   // category name (lookup)
    pub gear_type: String,          // "guitar" | "effect"
    pub year_start: Option<i32>,
    pub year_end: Option<i32>,
    pub description: Option<String>,
}

#[derive(Debug, Deserialize)]
pub struct GearQuery {
    pub q: Option<String>,          // search in gear.name
    pub gear_type: Option<String>,  // guitar|effect
    pub brand: Option<String>,      // brand name (ILIKE)
    pub page: Option<i64>,
    pub page_size: Option<i64>,
}
