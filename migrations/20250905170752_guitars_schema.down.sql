-- Drop trigger/function first
DROP TRIGGER IF EXISTS guitars_set_updated_at ON guitars;
DROP FUNCTION IF EXISTS set_updated_at;

-- Drop child tables (respect FKs)
DROP TABLE IF EXISTS guitar_badges;
DROP TABLE IF EXISTS guitar_provenance;
DROP TABLE IF EXISTS guitar_controls;
DROP TABLE IF EXISTS guitar_pickups;

DROP TABLE IF EXISTS guitar_case;
DROP TABLE IF EXISTS guitar_setup;
DROP TABLE IF EXISTS guitar_hardware;
DROP TABLE IF EXISTS guitar_finish;
DROP TABLE IF EXISTS guitar_woods;
DROP TABLE IF EXISTS guitar_appointments;
DROP TABLE IF EXISTS guitar_dimensions;

-- Finally the core
DROP TABLE IF EXISTS guitars;
-- Add down migration script here
