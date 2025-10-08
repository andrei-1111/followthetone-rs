BEGIN TRANSACTION;

LET $g = (
  CREATE guitars CONTENT {
    brand: "Banker",
    line: NULL,
    model: "Ironman CT Standard",
    variant: NULL,
    year_reference: NULL,
    weight: NULL,
    body_style: "Bound Double Cutaway",
    price_cents: NULL,
    price_currency: NULL,
    serial_number: NULL,
    created_at: time::now(),
    updated_at: time::now()
  }
);

CREATE guitar_dimensions CONTENT {
  guitar_id: $g.id,
  scale_length: "24 3/4\" (Vintage \"Rule of 18\")",
  nut_width: "1 5/8\"",
  neck_profile: "'60 \"C\" Shape",
  neck_thickness_1st: ".91",
  neck_thickness_12th: ".93",
  fingerboard_radius: "12\"",
  fret_count: NULL,
  fret_type: "Jescar 45085 Nickel Silver",
  binding: NULL
};

CREATE guitar_appointments CONTENT {
  guitar_id: $g.id,
  binding_body: "Bound body",
  binding_fingerboard: "1-Ply fingerboard binding",
  inlays: "Vintage Trapezoid",
  headstock_veneer: NULL,
  other: NULL
};

CREATE guitar_woods CONTENT {
  guitar_id: $g.id,
  top: "Carved Flame Maple Top",
  body: "Honduran Mahogany",
  neck: "Quartersawn Honduran Mahogany",
  fingerboard: "Rosewood",
  neck_joint: NULL,
  top_carve: "Carved"
};

CREATE guitar_finish CONTENT {
  guitar_id: $g.id,
  color: "Vintage Sunburst",
  type: "Nitrocellulose Lacquer",
  aging: NULL,
  colors: ["Vintage Sunburst", "Goldtop"],
  notes: NULL
};

CREATE guitar_hardware CONTENT {
  guitar_id: $g.id,
  material: NULL,
  bridge: "Faber ABR-H",
  tailpiece: "Tailpiece w/ Collarless Locking Studs",
  tuners: "Grover Rotomatic",
  pickguard: NULL,
  pickup_rings: "M69 Mounting Rings",
  notes: NULL
};

CREATE guitar_setup CONTENT {
  guitar_id: $g.id,
  strings: "Stringjoy 10–46 Pure Nickel",
  tuning: "Standard",
  action: "4/64",
  nut_material: "Unbleached Polished Bone",
  truss_rod: "2-Way Adjustable"
};

CREATE guitar_case CONTENT {
  guitar_id: $g.id,
  type: NULL,
  coa_included: NULL,
  notes: NULL
};

CREATE guitar_pickups CONTENT {
  guitar_id: $g.id,
  position: "Neck",
  type: "Humbucker",
  model: "Custom Throbak PAF",
  winding: NULL
};
CREATE guitar_pickups CONTENT {
  guitar_id: $g.id,
  position: "Bridge",
  type: "Humbucker",
  model: "Custom Throbak PAF",
  winding: NULL
};

CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Volume", detail: "CTS 550k Potentiometer" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Volume", detail: "CTS 550k Potentiometer" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", detail: "CTS 550k Potentiometer" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", detail: "CTS 550k Potentiometer" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "3-way Toggleswitch", detail: "Switchcraft" };

COMMIT TRANSACTION;
