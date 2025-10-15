-- Complete Database Schema Extracted from Live Database
-- This schema can be used to recreate your database structure

-- ======================
-- Database Definition
-- ======================
DEFINE DATABASE guitars;

-- ======================
-- Core Tables
-- ======================

-- Main guitars table
DEFINE TABLE guitars TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD brand ON guitars TYPE string ASSERT $value != "" PERMISSIONS FULL;
DEFINE FIELD line ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD model ON guitars TYPE string ASSERT $value != "" PERMISSIONS FULL;
DEFINE FIELD variant ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD year_reference ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD body_style ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD weight ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD slug ON guitars TYPE string PERMISSIONS FULL;
DEFINE FIELD created_at ON guitars TYPE datetime VALUE time::now() PERMISSIONS FULL;
DEFINE FIELD updated_at ON guitars TYPE datetime VALUE time::now() PERMISSIONS FULL;

-- Indexes for guitars
DEFINE INDEX idx_guitars_brand_model ON guitars FIELDS brand, model UNIQUE;
DEFINE INDEX slug_idx ON guitars FIELDS slug UNIQUE;

-- ======================
-- Guitar Detail Tables (1:1 relationships)
-- ======================

-- Dimensions
DEFINE TABLE guitar_dimensions TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD guitar_id ON guitar_dimensions TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD scale_length ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD nut_width ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD neck_profile ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD neck_thickness_1st ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD neck_thickness_12th ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD fingerboard_radius ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD fret_count ON guitar_dimensions TYPE option<number> PERMISSIONS FULL;
DEFINE FIELD fret_type ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD binding ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX uniq_dimensions_guitar ON guitar_dimensions FIELDS guitar_id UNIQUE;

-- Appointments
DEFINE TABLE guitar_appointments TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD guitar_id ON guitar_appointments TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD binding_body ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD binding_fingerboard ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD inlays ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD headstock_veneer ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD other ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX uniq_appointments_guitar ON guitar_appointments FIELDS guitar_id UNIQUE;

-- Woods
DEFINE TABLE guitar_woods TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD guitar_id ON guitar_woods TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD top ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD body ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD neck ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD fingerboard ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD neck_joint ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD top_carve ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX uniq_woods_guitar ON guitar_woods FIELDS guitar_id UNIQUE;

-- Finish
DEFINE TABLE guitar_finish TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD guitar_id ON guitar_finish TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD color ON guitar_finish TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD type ON guitar_finish TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD aging ON guitar_finish TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD colors ON guitar_finish TYPE option<array<string>> PERMISSIONS FULL;
DEFINE FIELD colors[*] ON guitar_finish TYPE string PERMISSIONS FULL;
DEFINE FIELD notes ON guitar_finish TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX uniq_finish_guitar ON guitar_finish FIELDS guitar_id UNIQUE;

-- Hardware
DEFINE TABLE guitar_hardware TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD guitar_id ON guitar_hardware TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD material ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD bridge ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD tailpiece ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD tuners ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD pickguard ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD pickup_rings ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD notes ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX uniq_hardware_guitar ON guitar_hardware FIELDS guitar_id UNIQUE;

-- Setup
DEFINE TABLE guitar_setup TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD guitar_id ON guitar_setup TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD strings ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD tuning ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD action ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD nut_material ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD truss_rod ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX uniq_setup_guitar ON guitar_setup FIELDS guitar_id UNIQUE;

-- Case / COA
DEFINE TABLE guitar_case TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD guitar_id ON guitar_case TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD type ON guitar_case TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD coa_included ON guitar_case TYPE option<bool> PERMISSIONS FULL;
DEFINE FIELD notes ON guitar_case TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX uniq_case_guitar ON guitar_case FIELDS guitar_id UNIQUE;

-- ======================
-- Guitar Detail Tables (1:N relationships)
-- ======================

-- Pickups
DEFINE TABLE guitar_pickups TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD guitar_id ON guitar_pickups TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD position ON guitar_pickups TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD type ON guitar_pickups TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD model ON guitar_pickups TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD winding ON guitar_pickups TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX idx_pickups_guitar ON guitar_pickups FIELDS guitar_id;

-- Controls
DEFINE TABLE guitar_controls TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD guitar_id ON guitar_controls TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD name ON guitar_controls TYPE string PERMISSIONS FULL;
DEFINE FIELD detail ON guitar_controls TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX idx_controls_guitar ON guitar_controls FIELDS guitar_id;

-- Badges
DEFINE TABLE guitar_badges TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD guitar_id ON guitar_badges TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD badge ON guitar_badges TYPE string PERMISSIONS FULL;
DEFINE INDEX guitar_badges_guitar_idx ON guitar_badges FIELDS guitar_id;

-- Provenance
DEFINE TABLE guitar_provenance TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
DEFINE FIELD guitar_id ON guitar_provenance TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD note ON guitar_provenance TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD url ON guitar_provenance TYPE option<string> PERMISSIONS FULL;
DEFINE INDEX guitar_provenance_guitar_idx ON guitar_provenance FIELDS guitar_id;
