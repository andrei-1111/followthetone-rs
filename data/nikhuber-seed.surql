-- Nik Huber Orca 59 — SurrealDB seed (using successful pattern)
-- Core guitar (capture id) - use unique model name to avoid duplicates
LET $g = (CREATE guitars CONTENT {
  brand: "Nik Huber",
  model: "Orca 59",
  body_style: "Les Paul Style",
  line: "",
  variant: "Brazilian Ice Tea Burst (55086)",
  year_reference: "",
  weight: "",
  price_cents: 0,
  price_currency: "USD",
  serial_number: "55086",
  slug: "nik-huber-orca-59-guitar",
  production_year: 0,
  spec_version_year: 0
} RETURN AFTER)[0];

-- Dimensions / specs
CREATE guitar_dimensions CONTENT {
  guitar_id: $g.id,
  scale_length: "24.75\"",
  nut_width: "1.67\" (42.5 mm)",
  neck_profile: "Orca Standard",
  neck_thickness_1st: "",
  neck_thickness_12th: "",
  fingerboard_radius: "Compound 10\"–14\"",
  fret_count: 22,
  fret_type: "Medium Jumbo (extra hard)",
  binding: ""
};

-- Appointments
CREATE guitar_appointments CONTENT {
  guitar_id: $g.id,
  binding_body: "",
  binding_fingerboard: "",
  inlays: "Crown MOP",
  headstock_veneer: "Ebony veneer",
  other: "Body shape: Orca 59 (Fat Back)"
};

-- Woods
CREATE guitar_woods CONTENT {
  guitar_id: $g.id,
  top: "Exceptional 5A Curly Maple (upgrade)",
  body: "Mahogany",
  neck: "Mahogany",
  fingerboard: "Super Dark Brazilian Rosewood (upgrade)",
  neck_joint: "",
  top_carve: ""
};

-- Finish
CREATE guitar_finish CONTENT {
  guitar_id: $g.id,
  color: "Ice Tea Burst",
  type: "Gloss",
  aging: "",
  colors: [],
  notes: "Finish & top listed as upgrades"
};

-- Hardware
CREATE guitar_hardware CONTENT {
  guitar_id: $g.id,
  material: "Nickel",
  bridge: "ABM AVR-2",
  tailpiece: "Aluminum Tailpiece",
  tuners: "Nik Huber 510 Open Gear",
  pickguard: "",
  pickup_rings: "",
  notes: ""
};

-- Setup
CREATE guitar_setup CONTENT {
  guitar_id: $g.id,
  strings: "",
  tuning: "",
  action: "",
  nut_material: "",
  truss_rod: ""
};

-- Case / COA
CREATE guitar_case CONTENT {
  guitar_id: $g.id,
  type: "Deluxe Hard Case",
  coa_included: false,
  notes: ""
};

-- Pickups (2x)
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Neck", type: "Humbucker", model: "Häussel 1959 (Aged Nickel Cover)", winding: "" };
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Bridge", type: "Humbucker", model: "Häussel 1959 (Aged Nickel Cover)", winding: "" };

-- Controls (5x)
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Volume", detail: "Neck" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Volume", detail: "Bridge" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", detail: "Neck (push/pull coil tap)" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", detail: "Bridge (push/pull coil tap)" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "3-way Toggleswitch", detail: "" };
