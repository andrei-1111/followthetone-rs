-- Nik Huber Krautster III — SurrealDB seed (using successful pattern)
-- Core guitar (capture id) - use unique model name to avoid duplicates
LET $g = (CREATE guitars CONTENT {
  brand: "Nik Huber",
  model: "Krautster III Import",
  body_style: "",
  line: "",
  variant: "Copper Top",
  year_reference: "",
  weight: "6 lbs 14 oz",
  serial_number: "44749",
  slug: "nik-huber-krautster-iii-import"
} RETURN AFTER)[0];

-- Dimensions / specs
CREATE guitar_dimensions CONTENT {
  guitar_id: $g.id,
  scale_length: "25.5\" (635 mm)",
  nut_width: "1 5/8\"",
  neck_profile: "'60 \"C\" Shape",
  neck_thickness_1st: ".91",
  neck_thickness_12th: ".93",
  fingerboard_radius: "Compound 10\"–14\" (255–355 mm)",
  fret_count: 22,
  fret_type: "Medium Jumbo, extra hard (2.49 mm W × 1.19 mm H), routed slots",
  binding: ""
};

-- Appointments
CREATE guitar_appointments CONTENT {
  guitar_id: $g.id,
  binding_body: "Cream front binding",
  binding_fingerboard: "",
  inlays: "Bone dot fingerboard inlays",
  headstock_veneer: "Ebony",
  other: "Black brushed bell knobs; Black brushed switch tip"
};

-- Woods
CREATE guitar_woods CONTENT {
  guitar_id: $g.id,
  top: "Copper top (finish over cap)",
  body: "Spanish Cedar",
  neck: "Flame Maple",
  fingerboard: "East Indian Rosewood",
  neck_joint: "",
  top_carve: ""
};

-- Finish
CREATE guitar_finish CONTENT {
  guitar_id: $g.id,
  color: "Copper Top",
  type: "Satin",
  aging: "",
  colors: [],
  notes: ""
};

-- Hardware
CREATE guitar_hardware CONTENT {
  guitar_id: $g.id,
  material: "Nickel",
  bridge: "Nick Huber Stop Tail Bridge",
  tailpiece: "",
  tuners: "Nick Huber 510 Open Gear (Tulip Buttons)",
  pickguard: "",
  pickup_rings: "",
  notes: ""
};

-- Setup
CREATE guitar_setup CONTENT {
  guitar_id: $g.id,
  strings: "010–046",
  tuning: "",
  action: "",
  nut_material: "Bone",
  truss_rod: "Double-action (single rod, compressed)"
};

-- Case / COA
CREATE guitar_case CONTENT {
  guitar_id: $g.id,
  type: "Hard Case",
  coa_included: false,
  notes: ""
};

-- Pickups (2x)
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Neck", type: "P90", model: "Custom P90 \"1956\"", winding: "" };
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Bridge", type: "Humbucker", model: "Krautster-B (H. Häussel) w/ aged nickel cover", winding: "" };

-- Controls (3x)
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Volume", detail: "Master" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", detail: "Master (push/pull coil tap)" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "3-way Toggleswitch", detail: "" };
