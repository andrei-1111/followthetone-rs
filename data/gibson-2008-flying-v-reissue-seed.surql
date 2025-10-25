-- Gibson 2008 Flying V Reissue (50th Anniversary) - SurQL Seed Script
-- Based on data/json/2.json

-- Core guitar (capture id) - use unique model name to avoid duplicates
LET $g = (CREATE guitars CONTENT {
  brand: "Gibson Custom Shop",
  model: "1958 Flying V Reissue 50th Anniversary",
  body_style: "Flying V",
  line: "Historic Collection",
  variant: "50th Anniversary",
  year_reference: "1958",
  weight: "7.4 lbs",
  price_cents: 0,
  price_currency: "USD",
  serial_number: "xx/100 (numbered run)",
  slug: "gibson-2008-flying-v-reissue-50th-anniversary",
  production_year: 2008,
  spec_version_year: 1958
} RETURN AFTER)[0];

-- Dimensions / specs
CREATE guitar_dimensions CONTENT {
  guitar_id: $g.id,
  scale_length: "24.75",
  nut_width: "1.687",
  neck_profile: "1958 rounded C",
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
  inlays: "Pearloid dots",
  headstock_veneer: "",
  other: "White 3-ply pickguard (vintage-style)"
};

-- Woods
CREATE guitar_woods CONTENT {
  guitar_id: $g.id,
  top: "",
  body: "Korina (African limba)",
  neck: "Korina (one-piece)",
  fingerboard: "Indian rosewood (dark)",
  neck_joint: "Set",
  top_carve: ""
};

-- Finish
CREATE guitar_finish CONTENT {
  guitar_id: $g.id,
  color: "Natural",
  type: "Natural nitrocellulose",
  aging: "",
  colors: ["Natural"],
  notes: "Natural nitrocellulose finish"
};

-- Hardware
CREATE guitar_hardware CONTENT {
  guitar_id: $g.id,
  material: "Nickel",
  bridge: "ABR-1 Tune-O-Matic",
  tailpiece: "V-shaped string-through plate",
  tuners: "Kluson Deluxe reissue",
  pickguard: "White 3-ply (vintage-style)",
  pickup_rings: "",
  notes: "Nickel plating, Lifton-style brown case with pink interior"
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
  type: "Lifton-style brown",
  coa_included: true,
  notes: "Pink interior, numbered run (xx/100)"
};

-- Pickups (2x)
CREATE guitar_pickups CONTENT {
  guitar_id: $g.id,
  position: "Neck",
  type: "Humbucker",
  model: "Gibson Custom PAF Reissue",
  winding: ""
};
CREATE guitar_pickups CONTENT {
  guitar_id: $g.id,
  position: "Bridge",
  type: "Humbucker",
  model: "Gibson Custom PAF Reissue",
  winding: ""
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
  note: "50th Anniversary Historic Collection reissue. Production quantity: 100 units. Factory: Nashville, Tennessee, USA. Anniversary reissue aims for vintage-correct Korina body/neck and period-correct hardware. Built by Gibson Custom Shop; widely regarded as a highly accurate Korina V recreation.",
  url: ""
};

-- Badges (multiple examples)
CREATE guitar_badges CONTENT {
  guitar_id: $g.id,
  badge: "50th Anniversary Historic Collection"
};
CREATE guitar_badges CONTENT {
  guitar_id: $g.id,
  badge: "Numbered Run (xx/100)"
};
CREATE guitar_badges CONTENT {
  guitar_id: $g.id,
  badge: "Gibson Custom Shop"
};