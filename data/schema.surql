-- SurrealDB schema generated from data/schema.sql

-- ======================
-- NS/DB are passed via CLI flags
-- ======================

-- Core: guitars
DEFINE TABLE IF NOT EXISTS guitars SCHEMAFULL;

DEFINE FIELD IF NOT EXISTS brand          ON TABLE guitars TYPE string ASSERT $value != "";
DEFINE FIELD IF NOT EXISTS line           ON TABLE guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS model          ON TABLE guitars TYPE string ASSERT $value != "";
DEFINE FIELD IF NOT EXISTS variant        ON TABLE guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS year_reference ON TABLE guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS body_style     ON TABLE guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS weight         ON TABLE guitars TYPE option<string>;

DEFINE FIELD IF NOT EXISTS created_at     ON TABLE guitars TYPE datetime VALUE time::now();
DEFINE FIELD IF NOT EXISTS updated_at     ON TABLE guitars TYPE datetime VALUE time::now();

DEFINE INDEX IF NOT EXISTS idx_guitars_brand_model ON TABLE guitars COLUMNS brand, model UNIQUE;

DEFINE EVENT IF NOT EXISTS guitars_touch ON TABLE guitars WHEN $event = "UPDATE" THEN { UPDATE $after SET updated_at = time::now(); };

-- ============ 1:1 tables (exactly one row per guitar) ============

-- Dimensions
DEFINE TABLE IF NOT EXISTS guitar_dimensions SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS guitar_id            ON TABLE guitar_dimensions TYPE record<guitars>;
DEFINE FIELD IF NOT EXISTS scale_length         ON TABLE guitar_dimensions TYPE option<string>;
DEFINE FIELD IF NOT EXISTS nut_width            ON TABLE guitar_dimensions TYPE option<string>;
DEFINE FIELD IF NOT EXISTS neck_profile         ON TABLE guitar_dimensions TYPE option<string>;
DEFINE FIELD IF NOT EXISTS neck_thickness_1st   ON TABLE guitar_dimensions TYPE option<string>;
DEFINE FIELD IF NOT EXISTS neck_thickness_12th  ON TABLE guitar_dimensions TYPE option<string>;
DEFINE FIELD IF NOT EXISTS fingerboard_radius   ON TABLE guitar_dimensions TYPE option<string>;
DEFINE FIELD IF NOT EXISTS fret_count           ON TABLE guitar_dimensions TYPE option<number>;
DEFINE FIELD IF NOT EXISTS fret_type            ON TABLE guitar_dimensions TYPE option<string>;
DEFINE FIELD IF NOT EXISTS binding              ON TABLE guitar_dimensions TYPE option<string>;
DEFINE INDEX IF NOT EXISTS uniq_dimensions_guitar ON TABLE guitar_dimensions COLUMNS guitar_id UNIQUE;

-- Appointments
DEFINE TABLE IF NOT EXISTS guitar_appointments SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS guitar_id            ON TABLE guitar_appointments TYPE record<guitars>;
DEFINE FIELD IF NOT EXISTS binding_body         ON TABLE guitar_appointments TYPE option<string>;
DEFINE FIELD IF NOT EXISTS binding_fingerboard  ON TABLE guitar_appointments TYPE option<string>;
DEFINE FIELD IF NOT EXISTS inlays               ON TABLE guitar_appointments TYPE option<string>;
DEFINE FIELD IF NOT EXISTS headstock_veneer     ON TABLE guitar_appointments TYPE option<string>;
DEFINE FIELD IF NOT EXISTS other                ON TABLE guitar_appointments TYPE option<string>;
DEFINE INDEX IF NOT EXISTS uniq_appointments_guitar ON TABLE guitar_appointments COLUMNS guitar_id UNIQUE;

-- Woods
DEFINE TABLE IF NOT EXISTS guitar_woods SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS guitar_id     ON TABLE guitar_woods TYPE record<guitars>;
DEFINE FIELD IF NOT EXISTS top           ON TABLE guitar_woods TYPE option<string>;
DEFINE FIELD IF NOT EXISTS body          ON TABLE guitar_woods TYPE option<string>;
DEFINE FIELD IF NOT EXISTS neck          ON TABLE guitar_woods TYPE option<string>;
DEFINE FIELD IF NOT EXISTS fingerboard   ON TABLE guitar_woods TYPE option<string>;
DEFINE FIELD IF NOT EXISTS neck_joint    ON TABLE guitar_woods TYPE option<string>;
DEFINE FIELD IF NOT EXISTS top_carve     ON TABLE guitar_woods TYPE option<string>;
DEFINE INDEX IF NOT EXISTS uniq_woods_guitar ON TABLE guitar_woods COLUMNS guitar_id UNIQUE;

-- Finish
DEFINE TABLE IF NOT EXISTS guitar_finish SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS guitar_id  ON TABLE guitar_finish TYPE record<guitars>;
DEFINE FIELD IF NOT EXISTS color      ON TABLE guitar_finish TYPE option<string>;
DEFINE FIELD IF NOT EXISTS type       ON TABLE guitar_finish TYPE option<string>;
DEFINE FIELD IF NOT EXISTS aging      ON TABLE guitar_finish TYPE option<string>;
DEFINE FIELD IF NOT EXISTS colors     ON TABLE guitar_finish TYPE option<array<string>>;
DEFINE FIELD IF NOT EXISTS notes      ON TABLE guitar_finish TYPE option<string>;
DEFINE INDEX IF NOT EXISTS uniq_finish_guitar ON TABLE guitar_finish COLUMNS guitar_id UNIQUE;

-- Hardware
DEFINE TABLE IF NOT EXISTS guitar_hardware SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS guitar_id     ON TABLE guitar_hardware TYPE record<guitars>;
DEFINE FIELD IF NOT EXISTS material      ON TABLE guitar_hardware TYPE option<string>;
DEFINE FIELD IF NOT EXISTS bridge        ON TABLE guitar_hardware TYPE option<string>;
DEFINE FIELD IF NOT EXISTS tailpiece     ON TABLE guitar_hardware TYPE option<string>;
DEFINE FIELD IF NOT EXISTS tuners        ON TABLE guitar_hardware TYPE option<string>;
DEFINE FIELD IF NOT EXISTS pickguard     ON TABLE guitar_hardware TYPE option<string>;
DEFINE FIELD IF NOT EXISTS pickup_rings  ON TABLE guitar_hardware TYPE option<string>;
DEFINE FIELD IF NOT EXISTS notes         ON TABLE guitar_hardware TYPE option<string>;
DEFINE INDEX IF NOT EXISTS uniq_hardware_guitar ON TABLE guitar_hardware COLUMNS guitar_id UNIQUE;

-- Setup
DEFINE TABLE IF NOT EXISTS guitar_setup SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS guitar_id     ON TABLE guitar_setup TYPE record<guitars>;
DEFINE FIELD IF NOT EXISTS strings       ON TABLE guitar_setup TYPE option<string>;
DEFINE FIELD IF NOT EXISTS tuning        ON TABLE guitar_setup TYPE option<string>;
DEFINE FIELD IF NOT EXISTS action        ON TABLE guitar_setup TYPE option<string>;
DEFINE FIELD IF NOT EXISTS nut_material  ON TABLE guitar_setup TYPE option<string>;
DEFINE FIELD IF NOT EXISTS truss_rod     ON TABLE guitar_setup TYPE option<string>;
DEFINE INDEX IF NOT EXISTS uniq_setup_guitar ON TABLE guitar_setup COLUMNS guitar_id UNIQUE;

-- Case / COA
DEFINE TABLE IF NOT EXISTS guitar_case SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS guitar_id     ON TABLE guitar_case TYPE record<guitars>;
DEFINE FIELD IF NOT EXISTS type          ON TABLE guitar_case TYPE option<string>;
DEFINE FIELD IF NOT EXISTS coa_included  ON TABLE guitar_case TYPE option<bool>;
DEFINE FIELD IF NOT EXISTS notes         ON TABLE guitar_case TYPE option<string>;
DEFINE INDEX IF NOT EXISTS uniq_case_guitar ON TABLE guitar_case COLUMNS guitar_id UNIQUE;

-- ============ 1:N tables ============

-- Pickups
DEFINE TABLE IF NOT EXISTS guitar_pickups SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS guitar_id  ON TABLE guitar_pickups TYPE record<guitars>;
DEFINE FIELD IF NOT EXISTS position   ON TABLE guitar_pickups TYPE option<string>;
DEFINE FIELD IF NOT EXISTS type       ON TABLE guitar_pickups TYPE option<string>;
DEFINE FIELD IF NOT EXISTS model      ON TABLE guitar_pickups TYPE option<string>;
DEFINE FIELD IF NOT EXISTS winding    ON TABLE guitar_pickups TYPE option<string>;
DEFINE INDEX IF NOT EXISTS idx_pickups_guitar ON TABLE guitar_pickups COLUMNS guitar_id;

-- Controls
DEFINE TABLE IF NOT EXISTS guitar_controls SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS guitar_id  ON TABLE guitar_controls TYPE record<guitars>;
DEFINE FIELD IF NOT EXISTS name       ON TABLE guitar_controls TYPE string;
DEFINE FIELD IF NOT EXISTS detail     ON TABLE guitar_controls TYPE option<string>;
DEFINE INDEX IF NOT EXISTS idx_controls_guitar ON TABLE guitar_controls COLUMNS guitar_id;

-- Badges (optional small 1:N)
DEFINE TABLE IF NOT EXISTS guitar_badges SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS guitar_id  ON TABLE guitar_badges TYPE record<guitars>;
DEFINE FIELD IF NOT EXISTS badge      ON TABLE guitar_badges TYPE string;
DEFINE INDEX IF NOT EXISTS guitar_badges_guitar_idx ON TABLE guitar_badges COLUMNS guitar_id;

-- Provenance (minimal, adjust as needed)
DEFINE TABLE IF NOT EXISTS guitar_provenance SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS guitar_id  ON TABLE guitar_provenance TYPE record<guitars>;
DEFINE FIELD IF NOT EXISTS note       ON TABLE guitar_provenance TYPE option<string>;
DEFINE FIELD IF NOT EXISTS url        ON TABLE guitar_provenance TYPE option<string>;
DEFINE INDEX IF NOT EXISTS guitar_provenance_guitar_idx ON TABLE guitar_provenance COLUMNS guitar_id;
