-- Gibson Murphy Lab Wildwood Spec 1960 Les Paul Standard Seed Data
-- Upsert version for SurrealDB

-- Create the main guitar record
CREATE guitars:gibson_1960_les_paul_wildwood_spec SET
  brand = 'Gibson Murphy Lab',
  line = 'Murphy Lab',
  model = 'Wildwood Spec 1960 Les Paul Standard',
  variant = '"Beauty of the Burst" Page 151',
  year_reference = '1960',
  weight = '8.51 lbs.',
  body_style = 'Les Paul',
  slug = 'gibson-murphy-lab-wildwood-spec-1960-les-paul-standard';

-- Create guitar dimensions
CREATE guitar_dimensions:gibson_1960_les_paul_wildwood_spec SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  scale_length = '24.75"',
  nut_width = '1.687"',
  neck_profile = '1960 SlimTaper',
  neck_thickness_1st = '.840',
  neck_thickness_12th = '.950',
  fingerboard_radius = '12"',
  fret_count = 22,
  fret_type = 'Authentic Medium Jumbo',
  binding = '1-Ply Royalite';

-- Create guitar woods
CREATE guitar_woods:gibson_1960_les_paul_wildwood_spec SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  top = '2-Piece Hand-Picked Figured Maple (Hot Hide Glue)',
  body = '1-Piece Lightweight Mahogany',
  neck = 'Solid Mahogany',
  fingerboard = 'Indian Rosewood (Hot Hide Glue)',
  neck_joint = 'Long Tenon with Hide Glue Fit';

-- Create guitar finish
CREATE guitar_finish:gibson_1960_les_paul_wildwood_spec SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  color = '"Beauty of the Burst" Page 151',
  type = 'Light Aged',
  aging = 'Light Aged';

-- Create guitar hardware
CREATE guitar_hardware:gibson_1960_les_paul_wildwood_spec SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  material = 'Murphy Lab Light-Aged Nickel',
  bridge = 'No-Wire ABR-1 (Nickel-Plated Brass Saddles)',
  tailpiece = 'Lightweight Aluminum Stopbar',
  tuners = 'Kluson Double-Ring Single-Line',
  pickguard = 'Laminated Cellulose Acetate Butyrate';

-- Create guitar setup
CREATE guitar_setup:gibson_1960_les_paul_wildwood_spec SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  strings = NONE,
  tuning = NONE,
  action = NONE,
  nut_material = 'Bone',
  truss_rod = NONE;

-- Create guitar case
CREATE guitar_case:gibson_1960_les_paul_wildwood_spec SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  type = 'Brown/Pink Lifton Reissue 5-Latch Case with Wildwood Spec Badge',
  coa_included = true,
  notes = NONE;

-- Create guitar pickups
CREATE guitar_pickups:gibson_1960_les_paul_wildwood_spec_neck SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  position = 'Neck',
  type = 'Humbucker',
  model = 'Wildwood Spec Custombucker',
  winding = NONE;

CREATE guitar_pickups:gibson_1960_les_paul_wildwood_spec_bridge SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  position = 'Bridge',
  type = 'Humbucker',
  model = 'Wildwood Spec Custombucker',
  winding = NONE;

-- Create guitar controls
CREATE guitar_controls:gibson_1960_les_paul_wildwood_spec_volume1 SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  name = 'Volume',
  detail = NONE;

CREATE guitar_controls:gibson_1960_les_paul_wildwood_spec_volume2 SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  name = 'Volume',
  detail = NONE;

CREATE guitar_controls:gibson_1960_les_paul_wildwood_spec_tone1 SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  name = 'Tone',
  detail = NONE;

CREATE guitar_controls:gibson_1960_les_paul_wildwood_spec_tone2 SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  name = 'Tone',
  detail = NONE;

CREATE guitar_controls:gibson_1960_les_paul_wildwood_spec_switch SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  name = '3-way Toggleswitch',
  detail = NONE;

-- Create guitar provenance
CREATE guitar_provenance:gibson_1960_les_paul_wildwood_spec SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  dealer_series = 'Wildwood Spec',
  notes = NONE;

-- Create guitar badges
CREATE guitar_badges:gibson_1960_les_paul_wildwood_spec SET
  guitar_id = guitars:gibson_1960_les_paul_wildwood_spec,
  badge = 'Wildwood Spec Badge';

