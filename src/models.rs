use serde::{Deserialize, Serialize};
use surrealdb::sql::Thing; // record id type "table:id"

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Guitar {
    pub id: Option<Thing>,     // Surreal record id, e.g. guitars:abc...
    pub brand: String,
    pub model: String,
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
