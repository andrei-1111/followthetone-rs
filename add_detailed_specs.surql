-- Add detailed specifications to the existing Banker 58' Spec V guitar
-- First update the main guitar record with price and year info
UPDATE guitars:s61r8j01tdycyr5mv0c7 SET price_cents = 469900;
UPDATE guitars:s61r8j01tdycyr5mv0c7 SET price_currency = "USD";
UPDATE guitars:s61r8j01tdycyr5mv0c7 SET production_year = 0;
UPDATE guitars:s61r8j01tdycyr5mv0c7 SET spec_version_year = 1958;

-- Create dimensions record
CREATE guitar_dimensions CONTENT {
  guitar_id: guitars:s61r8j01tdycyr5mv0c7,
  scale_length: "24 3/4\"",
  nut_width: "1 11/16\"",
  neck_profile: "'58 \"D\" Shape",
  neck_thickness_1st: ".94",
  neck_thickness_12th: ".97",
  radius: "12\"",
  fret_count: 22,
  fret_type: "Jescar 45085 Nickel Silver"
};

-- Create woods record
CREATE guitar_woods CONTENT {
  guitar_id: guitars:s61r8j01tdycyr5mv0c7,
  body: "Korina",
  neck: "Quartersawn Korina",
  fingerboard: "Rosewood",
  neck_joint: "Set Neck",
  top_carve: "N/A"
};

-- Create finish record
CREATE guitar_finish CONTENT {
  guitar_id: guitars:s61r8j01tdycyr5mv0c7,
  color: "Natural",
  type: "Aged Nitrocellulose Lacquer",
  aging: "Aged"
};

-- Create hardware record
CREATE guitar_hardware CONTENT {
  guitar_id: guitars:s61r8j01tdycyr5mv0c7,
  bridge: "Faber ABR-H Bridge",
  tailpiece: "Solid Brass \"V\" Tailpiece",
  tuners: "Kluson Deluxe Keystone",
  pickguard: "4 Ply White",
  pickup_rings: "M69 Mounting Rings"
};

-- Create electronics record
CREATE guitar_electronics CONTENT {
  guitar_id: guitars:s61r8j01tdycyr5mv0c7,
  neck_pickup: "PAF Humbucker",
  bridge_pickup: "PAF Humbucker",
  middle_pickup: "N/A",
  controls: "Volume / Volume / Tone",
  potentiometers: "CTS 550k",
  switch: "Switchcraft 3 Way"
};

-- Create appointments record
CREATE guitar_appointments CONTENT {
  guitar_id: guitars:s61r8j01tdycyr5mv0c7,
  inlays: "Celluloid Pearl Dot",
  binding: "N/A",
  other: "Vintage Correct Rubber Knee Rest + Recessed Rear Brass Ferrules"
};

-- Create setup record
CREATE guitar_setup CONTENT {
  guitar_id: guitars:s61r8j01tdycyr5mv0c7,
  strings: "Stringjoy 10-46 Pure Nickel",
  tuning: "Standard Tuning",
  action: "4/64",
  nut_material: "Unbleached Polished Bone",
  truss_rod: "2 Way Adjustable"
};
