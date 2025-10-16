-- Create schema for current database (SurrealDB)
-- Generated from live export + recent field additions

-- ======================
-- Database
-- ======================
DEFINE DATABASE IF NOT EXISTS guitars;

-- ======================
-- Core table: guitars
-- ======================
DEFINE TABLE IF NOT EXISTS guitars TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

-- Core fields
DEFINE FIELD IF NOT EXISTS brand           ON guitars TYPE string ASSERT $value != "" PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS line            ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS model           ON guitars TYPE string ASSERT $value != "" PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS variant         ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS year_reference  ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS body_style      ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS weight          ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS slug            ON guitars TYPE string PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS created_at      ON guitars TYPE datetime VALUE time::now() PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS updated_at      ON guitars TYPE datetime VALUE time::now() PERMISSIONS FULL;

-- Marketplace import fields
DEFINE FIELD IF NOT EXISTS external_source     ON guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS external_id         ON guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS listing_url         ON guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS hero_url            ON guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS display_title       ON guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS description_html    ON guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS listing_currency    ON guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS condition_slug      ON guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS condition_display   ON guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS categories          ON guitars TYPE option<array<string>>;
DEFINE FIELD IF NOT EXISTS categories[*]       ON guitars TYPE string;
DEFINE FIELD IF NOT EXISTS auction             ON guitars TYPE option<bool>;
DEFINE FIELD IF NOT EXISTS offers_enabled      ON guitars TYPE option<bool>;
DEFINE FIELD IF NOT EXISTS has_inventory       ON guitars TYPE option<bool>;
DEFINE FIELD IF NOT EXISTS inventory           ON guitars TYPE option<number>;
DEFINE FIELD IF NOT EXISTS created_at_market   ON guitars TYPE option<datetime>;
DEFINE FIELD IF NOT EXISTS published_at        ON guitars TYPE option<datetime>;
DEFINE FIELD IF NOT EXISTS shop_id             ON guitars TYPE option<number>;
DEFINE FIELD IF NOT EXISTS shop_name           ON guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS shop_slug           ON guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS finish_display      ON guitars TYPE option<string>;

-- Indexes
DEFINE INDEX IF NOT EXISTS idx_guitars_brand_model ON guitars FIELDS brand, model UNIQUE;
DEFINE INDEX IF NOT EXISTS slug_idx                 ON guitars FIELDS slug UNIQUE;
DEFINE INDEX IF NOT EXISTS guitars_ext_unique       ON guitars COLUMNS external_source, external_id UNIQUE;

-- ======================
-- 1:1 detail tables
-- ======================

-- Dimensions
DEFINE TABLE IF NOT EXISTS guitar_dimensions TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id            ON guitar_dimensions TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS scale_length         ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS nut_width            ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS neck_profile         ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS neck_thickness_1st   ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS neck_thickness_12th  ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS fingerboard_radius   ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS fret_count           ON guitar_dimensions TYPE option<number> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS fret_type            ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS binding              ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX IF NOT EXISTS uniq_dimensions_guitar ON guitar_dimensions FIELDS guitar_id UNIQUE;

-- Appointments
DEFINE TABLE IF NOT EXISTS guitar_appointments TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id           ON guitar_appointments TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS binding_body        ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS binding_fingerboard ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS inlays              ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS headstock_veneer    ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS other               ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX IF NOT EXISTS uniq_appointments_guitar ON guitar_appointments FIELDS guitar_id UNIQUE;

-- Woods
DEFINE TABLE IF NOT EXISTS guitar_woods TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id    ON guitar_woods TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS top          ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS body         ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS neck         ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS fingerboard  ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS neck_joint   ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS top_carve    ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX IF NOT EXISTS uniq_woods_guitar ON guitar_woods FIELDS guitar_id UNIQUE;

-- Finish
DEFINE TABLE IF NOT EXISTS guitar_finish TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id  ON guitar_finish TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS color      ON guitar_finish TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS type       ON guitar_finish TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS aging      ON guitar_finish TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS colors     ON guitar_finish TYPE option<array<string>> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS colors[*]  ON guitar_finish TYPE string PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS notes      ON guitar_finish TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX IF NOT EXISTS uniq_finish_guitar ON guitar_finish FIELDS guitar_id UNIQUE;

-- Hardware
DEFINE TABLE IF NOT EXISTS guitar_hardware TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id     ON guitar_hardware TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS material      ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS bridge        ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS tailpiece     ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS tuners        ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS pickguard     ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS pickup_rings  ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS notes         ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX IF NOT EXISTS uniq_hardware_guitar ON guitar_hardware FIELDS guitar_id UNIQUE;

-- Setup
DEFINE TABLE IF NOT EXISTS guitar_setup TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id     ON guitar_setup TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS strings       ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS tuning        ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS action        ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS nut_material  ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS truss_rod     ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX IF NOT EXISTS uniq_setup_guitar ON guitar_setup FIELDS guitar_id UNIQUE;

-- Case / COA
DEFINE TABLE IF NOT EXISTS guitar_case TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id     ON guitar_case TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS type          ON guitar_case TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS coa_included  ON guitar_case TYPE option<bool> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS notes         ON guitar_case TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX IF NOT EXISTS uniq_case_guitar ON guitar_case FIELDS guitar_id UNIQUE;

-- ======================
-- 1:N detail tables
-- ======================

-- Pickups
DEFINE TABLE IF NOT EXISTS guitar_pickups TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id  ON guitar_pickups TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS position   ON guitar_pickups TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS type       ON guitar_pickups TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS model      ON guitar_pickups TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS winding    ON guitar_pickups TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX IF NOT EXISTS idx_pickups_guitar ON guitar_pickups FIELDS guitar_id;

-- Controls
DEFINE TABLE IF NOT EXISTS guitar_controls TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id  ON guitar_controls TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS name       ON guitar_controls TYPE string PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS detail     ON guitar_controls TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX IF NOT EXISTS idx_controls_guitar ON guitar_controls FIELDS guitar_id;

-- Badges
DEFINE TABLE IF NOT EXISTS guitar_badges TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id  ON guitar_badges TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS badge      ON guitar_badges TYPE string PERMISSIONS FULL;
DEFINE INDEX IF NOT EXISTS guitar_badges_guitar_idx ON guitar_badges FIELDS guitar_id;

-- Provenance
DEFINE TABLE IF NOT EXISTS guitar_provenance TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id  ON guitar_provenance TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS note       ON guitar_provenance TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS url        ON guitar_provenance TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX IF NOT EXISTS guitar_provenance_guitar_idx ON guitar_provenance FIELDS guitar_id;


