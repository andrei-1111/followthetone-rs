-- Final seed file for guitars from to-import.md
-- Update V Custom and create BigsV with detailed specifications

-- Update V Custom with price
UPDATE guitars SET price_cents = 549900, price_currency = "USD" WHERE brand = "Banker" AND model = "V Custom";

-- Get V Custom ID
LET $v_custom_id = (SELECT id FROM guitars WHERE brand = "Banker" AND model = "V Custom" LIMIT 1)[0].id;

-- Create BigsV guitar
LET $bigsv = (CREATE guitars CONTENT {
  brand: "Banker",
  model: "BigsV",
  slug: "banker-bigsv",
  body_style: "V",
  line: "",
  variant: "",
  year_reference: "",
  weight: "",
  price_cents: 499900,
  price_currency: "USD",
  serial_number: "",
  hero_image_url: "",
  image_gallery: [],
  image_source: "",
  condition: "",
  status: "",
  production_year: 0,
  spec_version_year: 0,
  external_source: "",
  external_id: "",
  listing_url: "",
  shop_name: "",
  shop_slug: "",
  hero_url: ""
} RETURN AFTER)[0];

-- V Custom dimensions
CREATE guitar_dimensions CONTENT {
  guitar_id: $v_custom_id,
  scale_length: "24 3/4\" (Vintage \"Rule of 18\")",
  nut_width: "1 11/16\"",
  neck_profile: "'58 \"D\" Shape",
  neck_thickness_1st: ".94",
  neck_thickness_12th: ".97",
  radius: "12\"",
  fret_count: 22,
  fret_type: "Jescar 45085 Nickel Silver",
  binding: "1 Ply White Binding"
};

-- V Custom woods
CREATE guitar_woods CONTENT {
  guitar_id: $v_custom_id,
  body: "Korina 5 Ply W/B/W/B/W Double Bound",
  neck: "Quartersawn Korina",
  fingerboard: "Ebony",
  neck_joint: "",
  top: "",
  top_carve: ""
};

-- V Custom finish
CREATE guitar_finish CONTENT {
  guitar_id: $v_custom_id,
  color: "Black or White Natural",
  type: "Aged Nitrocellulose Lacquer",
  aging: "Aged",
  colors: [],
  notes: ""
};

-- V Custom hardware
CREATE guitar_hardware CONTENT {
  guitar_id: $v_custom_id,
  material: "",
  bridge: "Faber ABR-H Bridge",
  tailpiece: "Solid Brass \"V\" Tailpiece",
  tuners: "Kluson",
  pickguard: "",
  pickup_rings: "M69 Mounting Rings",
  notes: ""
};

-- V Custom electronics
CREATE guitar_electronics CONTENT {
  guitar_id: $v_custom_id,
  bridge_pickup: "PAF Humbucker",
  middle_pickup: "N/A",
  neck_pickup: "PAF Humbucker",
  controls: "Volume / Volume / Tone",
  potentiometers: "CTS 550k Potentiometers",
  switch: "Switchcraft 3 Way"
};

-- V Custom appointments
CREATE guitar_appointments CONTENT {
  guitar_id: $v_custom_id,
  binding_body: "5 Ply W/B/W/B/W Double Bound",
  binding_fingerboard: "1 Ply White Binding",
  headstock_veneer: "",
  inlays: "Pearl Block",
  other: ""
};

-- V Custom setup
CREATE guitar_setup CONTENT {
  guitar_id: $v_custom_id,
  strings: "Stringjoy 10-46 Pure Nickel",
  tuning: "Standard Tuning",
  action: "4/64",
  nut_material: "1 11/16\" Unbleached Polished Bone",
  truss_rod: "2 Way Adjustable"
};

-- V Custom case
CREATE guitar_case CONTENT {
  guitar_id: $v_custom_id,
  type: "",
  coa_included: false,
  notes: ""
};

-- V Custom pickups
CREATE guitar_pickups CONTENT {
  guitar_id: $v_custom_id,
  position: "Bridge",
  type: "Humbucker",
  model: "PAF Humbucker",
  winding: ""
};

CREATE guitar_pickups CONTENT {
  guitar_id: $v_custom_id,
  position: "Neck",
  type: "Humbucker",
  model: "PAF Humbucker",
  winding: ""
};

-- V Custom controls
CREATE guitar_controls CONTENT {
  guitar_id: $v_custom_id,
  name: "Volume",
  detail: "CTS 550k Potentiometer"
};

CREATE guitar_controls CONTENT {
  guitar_id: $v_custom_id,
  name: "Volume",
  detail: "CTS 550k Potentiometer"
};

CREATE guitar_controls CONTENT {
  guitar_id: $v_custom_id,
  name: "Tone",
  detail: "CTS 550k Potentiometer"
};

CREATE guitar_controls CONTENT {
  guitar_id: $v_custom_id,
  name: "3-way Switch",
  detail: "Switchcraft 3 Way"
};

-- BigsV dimensions
CREATE guitar_dimensions CONTENT {
  guitar_id: $bigsv.id,
  scale_length: "24 3/4\" (Vintage \"Rule of 18\")",
  nut_width: "1 11/16\"",
  neck_profile: "'58 \"D\" Shape",
  neck_thickness_1st: ".94",
  neck_thickness_12th: ".97",
  radius: "12\"",
  fret_count: 22,
  fret_type: "Jescar 45085 Nickel Silver",
  binding: ""
};

-- BigsV woods
CREATE guitar_woods CONTENT {
  guitar_id: $bigsv.id,
  body: "Korina",
  neck: "Quartersawn Korina",
  fingerboard: "Rosewood",
  neck_joint: "",
  top: "",
  top_carve: ""
};

-- BigsV finish
CREATE guitar_finish CONTENT {
  guitar_id: $bigsv.id,
  color: "",
  type: "Nitrocellulose Lacquer",
  aging: "",
  colors: [],
  notes: ""
};

-- BigsV hardware
CREATE guitar_hardware CONTENT {
  guitar_id: $bigsv.id,
  material: "",
  bridge: "Faber ABR-H Bridge",
  tailpiece: "Bigsby B7 Vibrato w/ Vibramate Bracket",
  tuners: "Grover Vintage Keystone",
  pickguard: "",
  pickup_rings: "M69 Mounting Rings",
  notes: ""
};

-- BigsV electronics
CREATE guitar_electronics CONTENT {
  guitar_id: $bigsv.id,
  bridge_pickup: "PAF Humbucker",
  middle_pickup: "N/A",
  neck_pickup: "PAF Humbucker",
  controls: "Volume / Volume / Tone",
  potentiometers: "CTS 550k Potentiometers",
  switch: "Switchcraft 3 Way"
};

-- BigsV appointments
CREATE guitar_appointments CONTENT {
  guitar_id: $bigsv.id,
  binding_body: "",
  binding_fingerboard: "",
  headstock_veneer: "",
  inlays: "Celluloid Pearl Dot",
  other: ""
};

-- BigsV setup
CREATE guitar_setup CONTENT {
  guitar_id: $bigsv.id,
  strings: "Stringjoy 10-46 Pure Nickel",
  tuning: "Standard Tuning",
  action: "4/64",
  nut_material: "1 11/16\" Unbleached Polished Bone",
  truss_rod: "2 Way Adjustable"
};

-- BigsV case
CREATE guitar_case CONTENT {
  guitar_id: $bigsv.id,
  type: "",
  coa_included: false,
  notes: ""
};

-- BigsV pickups
CREATE guitar_pickups CONTENT {
  guitar_id: $bigsv.id,
  position: "Bridge",
  type: "Humbucker",
  model: "PAF Humbucker",
  winding: ""
};

CREATE guitar_pickups CONTENT {
  guitar_id: $bigsv.id,
  position: "Neck",
  type: "Humbucker",
  model: "PAF Humbucker",
  winding: ""
};

-- BigsV controls
CREATE guitar_controls CONTENT {
  guitar_id: $bigsv.id,
  name: "Volume",
  detail: "CTS 550k Potentiometer"
};

CREATE guitar_controls CONTENT {
  guitar_id: $bigsv.id,
  name: "Volume",
  detail: "CTS 550k Potentiometer"
};

CREATE guitar_controls CONTENT {
  guitar_id: $bigsv.id,
  name: "Tone",
  detail: "CTS 550k Potentiometer"
};

CREATE guitar_controls CONTENT {
  guitar_id: $bigsv.id,
  name: "3-way Switch",
  detail: "Switchcraft 3 Way"
};

-- Summary
SELECT id, brand, model, slug, price_cents, price_currency FROM guitars WHERE brand = "Banker" AND model IN ["V Custom", "BigsV"];
