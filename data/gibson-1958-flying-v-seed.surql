-- Gibson 1958 Flying V (Original) - SurQL Seed Script
-- Based on data/json/1.json

-- Core guitar (capture id) - use unique model name to avoid duplicates
LET $g = (CREATE guitars CONTENT {
  brand: "Gibson",
  model: "1958 Flying V Original",
  body_style: "Flying V",
  line: "Original",
  variant: "1958",
  year_reference: "1958",
  weight: "7.4 lbs",
  price_cents: 0,
  price_currency: "USD",
  serial_number: "8xxxxx (1958)",
  slug: "gibson-1958-flying-v-original",
  production_year: 1958,
  spec_version_year: 1958
} RETURN AFTER)[0];

-- Dimensions / specs
CREATE guitar_dimensions CONTENT {
  guitar_id: $g.id,
  scale_length: "24.75",
  nut_width: "1.687",
  neck_profile: "Thick 1950s rounded C",
  neck_thickness_1st: "",
  neck_thickness_12th: "",
  fingerboard_radius: "12",
  fret_count: 22,
  fret_type: "22-fret",
  binding: ""
};

-- Appointments
CREATE guitar_appointments CONTENT {
  guitar_id: $g.id,
  binding_body: "",
  binding_fingerboard: "",
  inlays: "Dot",
  headstock_veneer: "",
  other: "Large white multi-ply pickguard"
};

-- Woods
CREATE guitar_woods CONTENT {
  guitar_id: $g.id,
  top: "",
  body: "Korina (African limba)",
  neck: "Korina (one piece)",
  fingerboard: "Rosewood",
  neck_joint: "Set",
  top_carve: ""
};

-- Finish
CREATE guitar_finish CONTENT {
  guitar_id: $g.id,
  color: "Natural",
  type: "Nitrocellulose",
  aging: "",
  colors: ["Natural"],
  notes: "Natural nitro finish"
};

-- Hardware
CREATE guitar_hardware CONTENT {
  guitar_id: $g.id,
  material: "Nickel",
  bridge: "ABR-1 Tune-O-Matic",
  tailpiece: "V-shaped brass string-through (nickel plated)",
  tuners: "Kluson Deluxe (single-line)",
  pickguard: "Large white (multi-ply)",
  pickup_rings: "",
  notes: "Nickel plating throughout"
};

-- Setup
CREATE guitar_setup CONTENT {
  guitar_id: $g.id,
  strings: "",
  tuning: "Standard",
  action: "",
  nut_material: "",
  truss_rod: ""
};

-- Case / COA
CREATE guitar_case CONTENT {
  guitar_id: $g.id,
  type: "Brown Lifton",
  coa_included: false,
  notes: "Pink interior"
};

-- Pickups (2x)
CREATE guitar_pickups CONTENT {
  guitar_id: $g.id,
  position: "Neck",
  type: "PAF humbucker",
  model: "PAF humbucker",
  winding: "Alnico, 7.4k ohm estimated"
};
CREATE guitar_pickups CONTENT {
  guitar_id: $g.id,
  position: "Bridge",
  type: "PAF humbucker",
  model: "PAF humbucker",
  winding: "Alnico, 7.6k ohm estimated"
};

-- Controls (3x)
CREATE guitar_controls CONTENT {
  guitar_id: $g.id,
  name: "Volume",
  detail: "2x volume controls"
};
CREATE guitar_controls CONTENT {
  guitar_id: $g.id,
  name: "Tone",
  detail: "1x tone control"
};
CREATE guitar_controls CONTENT {
  guitar_id: $g.id,
  name: "3-way Toggle",
  detail: "3-way toggle switch"
};

-- Provenance
CREATE guitar_provenance CONTENT {
  guitar_id: $g.id,
  note: "First-year production; extremely low sales led to discontinuation by 1959. Production quantity estimate: 81 units. Factory: Kalamazoo, Michigan, USA",
  url: ""
};