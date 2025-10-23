-- Banker 58' Spec V — SurrealDB seed (using successful pattern)
-- Core guitar (capture id) - use unique model name to avoid duplicates
LET $g = (CREATE guitars CONTENT {
  brand: "Banker",
  model: "58' Spec V Test",
  body_style: "V",
  line: "",
  variant: "",
  year_reference: "1958",
  weight: "",
  serial_number: "",
  slug: "banker-58-spec-v-test"
} RETURN AFTER)[0];

-- Dimensions / specs
CREATE guitar_dimensions CONTENT {
  guitar_id: $g.id,
  scale_length: '24 3/4" (Vintage "Rule of 18")',
  nut_width: '1 11/16"',
  neck_profile: "'58 D Shape",
  neck_thickness_1st: '.94',
  neck_thickness_12th: '.97',
  fingerboard_radius: '12"',
  fret_count: 22,
  fret_type: 'Jescar 45085 Nickel Silver',
  binding: ''
};

-- Appointments
CREATE guitar_appointments CONTENT {
  guitar_id: $g.id,
  binding_body: "",
  binding_fingerboard: "",
  inlays: "",
  headstock_veneer: "",
  other: ""
};

-- Woods
CREATE guitar_woods CONTENT {
  guitar_id: $g.id,
  top: "",
  body: "Korina",
  neck: "Quartersawn Korina",
  fingerboard: "Rosewood",
  neck_joint: "",
  top_carve: ""
};

-- Finish
CREATE guitar_finish CONTENT {
  guitar_id: $g.id,
  color: "Natural",
  type: "Nitrocellulose Lacquer",
  aging: "Aged",
  colors: [],
  notes: ""
};

-- Hardware
CREATE guitar_hardware CONTENT {
  guitar_id: $g.id,
  material: "",
  bridge: "Faber ABR-H",
  tailpiece: "Solid Brass \"V\" Tailpiece",
  tuners: "Kluson Deluxe Keystone",
  pickguard: "4 Ply White",
  pickup_rings: "",
  notes: ""
};

-- Setup
CREATE guitar_setup CONTENT {
  guitar_id: $g.id,
  strings: "Stringjoy 10–46 Pure Nickel",
  tuning: "Standard",
  action: "4/64",
  nut_material: "Unbleached Polished Bone",
  truss_rod: "2-Way Adjustable"
};

-- Case / COA
CREATE guitar_case CONTENT {
  guitar_id: $g.id,
  type: "",
  coa_included: true,
  notes: ""
};

-- Pickups (2x)
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Neck", type: "Humbucker", model: "PAF Humbucker", winding: "" };
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Bridge", type: "Humbucker", model: "PAF Humbucker", winding: "" };

-- Controls (4x)
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Volume", detail: "CTS 550k Potentiometer" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Volume", detail: "CTS 550k Potentiometer" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", detail: "CTS 550k Potentiometer" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "3-way Toggleswitch", detail: "Switchcraft" };

-- Summary (optional)
SELECT id, brand, model FROM guitars WHERE id = $g.id;
SELECT count() AS pickup_count FROM guitar_pickups WHERE guitar_id = $g.id;
SELECT count() AS control_count FROM guitar_controls WHERE guitar_id = $g.id;
