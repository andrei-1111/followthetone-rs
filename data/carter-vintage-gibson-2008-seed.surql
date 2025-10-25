-- Carter Vintage Gibson 50th Anniversary Korina Flying V 2008 - SurQL Seed Script
-- Based on data/json/3.json

-- Core guitar (capture id) - use unique model name to avoid duplicates
LET $g = (CREATE guitars CONTENT {
  brand: "Gibson",
  model: "50th Anniversary Korina Flying V",
  body_style: "Flying V",
  line: "Custom Shop",
  variant: "50th Anniversary",
  year_reference: "1958",
  weight: "7.0 lbs",
  price_cents: 995000,
  price_currency: "USD",
  serial_number: "Carter Vintage GS8725-A",
  slug: "gibson-50th-anniversary-korina-flying-v",
  production_year: 2008,
  spec_version_year: 1958,
  external_source: "Carter Vintage Guitars",
  external_id: "GS8725-A",
  listing_url: "https://cartervintage.com/shop/gibson-50th-anniversary-korina-flying-v-2008-natural/2oUm1jEHykN7WDOySPHm95ZAr49",
  shop_name: "Carter Vintage Guitars",
  shop_slug: "carter-vintage"
} RETURN AFTER)[0];

-- Dimensions / specs
CREATE guitar_dimensions CONTENT {
  guitar_id: $g.id,
  scale_length: "24.75",
  nut_width: "1.71",
  neck_profile: "C",
  neck_thickness_1st: "0.92",
  neck_thickness_12th: "0.96",
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
  other: "Original electronics"
};

-- Woods
CREATE guitar_woods CONTENT {
  guitar_id: $g.id,
  top: "",
  body: "Korina",
  neck: "Korina",
  fingerboard: "Rosewood",
  neck_joint: "Set",
  top_carve: ""
};

-- Finish
CREATE guitar_finish CONTENT {
  guitar_id: $g.id,
  color: "Natural",
  type: "Natural",
  aging: "",
  colors: ["Natural"],
  notes: "Natural finish"
};

-- Hardware
CREATE guitar_hardware CONTENT {
  guitar_id: $g.id,
  material: "Original",
  bridge: "Original",
  tailpiece: "Original",
  tuners: "Original",
  pickguard: "Original",
  pickup_rings: "Original",
  notes: "Original hardware throughout"
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
  type: "OHSC (Original Hard Shell Case)",
  coa_included: true,
  notes: "Certificate of authenticity included"
};

-- Pickups (2x - estimated based on Flying V standard)
CREATE guitar_pickups CONTENT {
  guitar_id: $g.id,
  position: "Neck",
  type: "Humbucker",
  model: "Original",
  winding: "7.7k ohm impedance"
};
CREATE guitar_pickups CONTENT {
  guitar_id: $g.id,
  position: "Bridge",
  type: "Humbucker",
  model: "Original",
  winding: "7.7k ohm impedance"
};

-- Controls (3x - standard Flying V layout)
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
  note: "Carter Vintage Guitars listing - 50th Anniversary tribute to the original 1958 Flying V. Gibson Custom Shop construction with Natural finish, Korina body, and C-profile neck with rosewood fingerboard. Excellent condition with original hardshell case and certificate of authenticity.",
  url: "https://cartervintage.com/shop/gibson-50th-anniversary-korina-flying-v-2008-natural/2oUm1jEHykN7WDOySPHm95ZAr49"
};

-- Badges
CREATE guitar_badges CONTENT {
  guitar_id: $g.id,
  badge: "50th Anniversary"
};
CREATE guitar_badges CONTENT {
  guitar_id: $g.id,
  badge: "Gibson Custom Shop"
};
CREATE guitar_badges CONTENT {
  guitar_id: $g.id,
  badge: "Carter Vintage Authenticated"
};
