-- Enable UUIDs
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ======================
-- Core entity
-- ======================
CREATE TABLE IF NOT EXISTS guitars (
  id             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  brand          TEXT        NOT NULL,
  line           TEXT,
  model          TEXT        NOT NULL,
  variant        TEXT,
  year_reference TEXT,
  body_style     TEXT,
  weight         TEXT,

  price_cents    INTEGER,
  price_currency TEXT,
  serial_number  TEXT,

  created_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE UNIQUE INDEX IF NOT EXISTS guitars_serial_uniq
  ON guitars (serial_number) WHERE serial_number IS NOT NULL;

CREATE INDEX IF NOT EXISTS guitars_brand_model_idx
  ON guitars (brand, model);

-- Dimensions (1:1)
CREATE TABLE IF NOT EXISTS guitar_dimensions (
  guitar_id             UUID PRIMARY KEY REFERENCES guitars(id) ON DELETE CASCADE,
  scale_length          TEXT,
  nut_width             TEXT,
  neck_profile          TEXT,
  neck_thickness_1st    TEXT,
  neck_thickness_12th   TEXT,
  fingerboard_radius    TEXT,
  fret_count            INT,
  fret_type             TEXT,
  binding               TEXT
);

-- Appointments / cosmetics (1:1)
CREATE TABLE IF NOT EXISTS guitar_appointments (
  guitar_id            UUID PRIMARY KEY REFERENCES guitars(id) ON DELETE CASCADE,
  binding_body         TEXT,
  binding_fingerboard  TEXT,
  inlays               TEXT,
  headstock_veneer     TEXT,
  other                TEXT
);

-- Woods (1:1)
CREATE TABLE IF NOT EXISTS guitar_woods (
  guitar_id   UUID PRIMARY KEY REFERENCES guitars(id) ON DELETE CASCADE,
  top         TEXT,
  body        TEXT,
  neck        TEXT,
  fingerboard TEXT,
  neck_joint  TEXT,
  top_carve   TEXT
);

-- Finish (1:1)
CREATE TABLE IF NOT EXISTS guitar_finish (
  guitar_id UUID PRIMARY KEY REFERENCES guitars(id) ON DELETE CASCADE,
  color     TEXT,
  type      TEXT,
  aging     TEXT,
  colors    TEXT[],
  notes     TEXT
);
CREATE INDEX IF NOT EXISTS guitar_finish_colors_gin
  ON guitar_finish USING GIN (colors);

-- Hardware (1:1)
CREATE TABLE IF NOT EXISTS guitar_hardware (
  guitar_id    UUID PRIMARY KEY REFERENCES guitars(id) ON DELETE CASCADE,
  material     TEXT,
  bridge       TEXT,
  tailpiece    TEXT,
  tuners       TEXT,
  pickguard    TEXT,
  pickup_rings TEXT,
  notes        TEXT
);

-- Setup (1:1)
CREATE TABLE IF NOT EXISTS guitar_setup (
  guitar_id    UUID PRIMARY KEY REFERENCES guitars(id) ON DELETE CASCADE,
  strings      TEXT,
  tuning       TEXT,
  action       TEXT,
  nut_material TEXT,
  truss_rod    TEXT
);

-- Case / COA (1:1)
CREATE TABLE IF NOT EXISTS guitar_case (
  guitar_id    UUID PRIMARY KEY REFERENCES guitars(id) ON DELETE CASCADE,
  type         TEXT,
  coa_included BOOLEAN,
  notes        TEXT
);

-- Electronics (1:N)
CREATE TABLE IF NOT EXISTS guitar_pickups (
  id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  guitar_id UUID NOT NULL REFERENCES guitars(id) ON DELETE CASCADE,
  position  TEXT,
  type      TEXT,
  model     TEXT,
  winding   TEXT
);
CREATE INDEX IF NOT EXISTS guitar_pickups_guitar_idx ON guitar_pickups (guitar_id);

CREATE TABLE IF NOT EXISTS guitar_controls (
  id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  guitar_id UUID NOT NULL REFERENCES guitars(id) ON DELETE CASCADE,
  name      TEXT,
  detail    TEXT
);
CREATE INDEX IF NOT EXISTS guitar_controls_guitar_idx ON guitar_controls (guitar_id);

-- Provenance / badges (optional)
CREATE TABLE IF NOT EXISTS guitar_provenance (
  guitar_id     UUID PRIMARY KEY REFERENCES guitars(id) ON DELETE CASCADE,
  dealer_series TEXT,
  notes         TEXT
);

CREATE TABLE IF NOT EXISTS guitar_badges (
  id        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  guitar_id UUID NOT NULL REFERENCES guitars(id) ON DELETE CASCADE,
  badge     TEXT
);
CREATE INDEX IF NOT EXISTS guitar_badges_guitar_idx ON guitar_badges (guitar_id);

-- Updated-at trigger
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS guitars_set_updated_at ON guitars;
CREATE TRIGGER guitars_set_updated_at
BEFORE UPDATE ON guitars
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();
