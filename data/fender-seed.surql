-- Fender Custom Shop '61 Strat Wildwood 10 Seed Data
-- Using successful pattern from banker-seed.surql

-- Core guitar (capture id) - use unique model name to avoid duplicates
LET $g = (CREATE guitars CONTENT {
  brand: "Fender Custom Shop",
  model: "61 Strat Wildwood 10 Test",
  body_style: "Stratocaster",
  line: "Dealer Select Wildwood 10",
  variant: "Red Sparkle Over 3-Tone Sunburst",
  year_reference: "1961",
  weight: "7.30 lbs.",
  slug: "fender-custom-shop-61-strat-wildwood10-test"
} RETURN AFTER)[0];

-- Dimensions / specs
CREATE guitar_dimensions CONTENT {
  guitar_id: $g.id,
  scale_length: "25.5\"",
  nut_width: "1.650\"",
  neck_profile: "60 Oval C",
  neck_thickness_1st: ".810",
  neck_thickness_12th: ".940",
  fingerboard_radius: "Wildwood Custom 10\"",
  fret_count: 21,
  fret_type: "6105 Narrow-Tall",
  binding: ""
};

-- Woods
CREATE guitar_woods CONTENT {
  guitar_id: $g.id,
  top: "",
  body: "Alder",
  neck: "Quartersawn Maple",
  fingerboard: "AAA Indian Rosewood",
  neck_joint: "",
  top_carve: ""
};

-- Finish
CREATE guitar_finish CONTENT {
  guitar_id: $g.id,
  color: "Red Sparkle Over 3-Tone Sunburst",
  type: "Nitrocellulose Lacquer",
  aging: "Heavy Relic",
  colors: [],
  notes: ""
};

-- Hardware
CREATE guitar_hardware CONTENT {
  guitar_id: $g.id,
  material: "Nickel/Chrome",
  bridge: "Vintage Tremolo",
  tailpiece: "",
  tuners: "Vintage-Style",
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
  nut_material: "Bone",
  truss_rod: ""
};

-- Case / COA
CREATE guitar_case CONTENT {
  guitar_id: $g.id,
  type: "Limited Edition Hardshell Case with Embroidered Custom Shop Logo",
  coa_included: true,
  notes: ""
};

-- Pickups (3x)
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Neck", type: "Single-Coil", model: "Hand-Wound Wildwood 10 Strat", winding: "" };
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Middle", type: "Single-Coil", model: "Hand-Wound Wildwood 10 Strat", winding: "" };
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Bridge", type: "Single-Coil", model: "Hand-Wound Wildwood 10 Strat", winding: "" };

-- Controls (4x)
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Volume", detail: "" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", detail: "" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", detail: "" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "5-way Switch", detail: "" };

-- Provenance
CREATE guitar_provenance CONTENT { guitar_id: $g.id, note: "Wildwood 10 Dealer Series", url: "" };

