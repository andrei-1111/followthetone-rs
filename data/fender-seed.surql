-- Fender Custom Shop '61 Strat Wildwood 10 Seed Data
-- Upsert version for SurrealDB

-- Create the main guitar record
CREATE guitars:fender_61_strat_wildwood10 SET
  brand = 'Fender Custom Shop',
  line = 'Dealer Select Wildwood 10',
  model = '61 Strat',
  variant = 'Red Sparkle Over 3-Tone Sunburst',
  year_reference = '1961',
  weight = '7.30 lbs.',
  body_style = 'Stratocaster',
  slug = 'fender-custom-shop-61-strat-wildwood10';

-- Create guitar dimensions
CREATE guitar_dimensions:fender_61_strat_wildwood10 SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  scale_length = '25.5"',
  nut_width = '1.650"',
  neck_profile = '60 Oval C',
  neck_thickness_1st = '.810',
  neck_thickness_12th = '.940',
  fingerboard_radius = 'Wildwood Custom 10"',
  fret_count = 21,
  fret_type = '6105 Narrow-Tall',
  binding = NONE;

-- Create guitar woods
CREATE guitar_woods:fender_61_strat_wildwood10 SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  top = NONE,
  body = 'Alder',
  neck = 'Quartersawn Maple',
  fingerboard = 'AAA Indian Rosewood',
  neck_joint = NONE;

-- Create guitar finish
CREATE guitar_finish:fender_61_strat_wildwood10 SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  color = 'Red Sparkle Over 3-Tone Sunburst',
  type = 'Nitrocellulose Lacquer',
  aging = 'Heavy Relic';

-- Create guitar hardware
CREATE guitar_hardware:fender_61_strat_wildwood10 SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  material = 'Nickel/Chrome',
  bridge = 'Vintage Tremolo',
  tailpiece = NONE,
  tuners = 'Vintage-Style',
  pickguard = NONE;

-- Create guitar setup
CREATE guitar_setup:fender_61_strat_wildwood10 SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  strings = NONE,
  tuning = NONE,
  action = NONE,
  nut_material = 'Bone',
  truss_rod = NONE;

-- Create guitar case
CREATE guitar_case:fender_61_strat_wildwood10 SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  type = 'Limited Edition Hardshell Case with Embroidered Custom Shop Logo',
  coa_included = true,
  notes = NONE;

-- Create guitar pickups
CREATE guitar_pickups:fender_61_strat_wildwood10_neck SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  position = 'Neck',
  type = 'Single-Coil',
  model = 'Hand-Wound Wildwood 10 Strat',
  winding = NONE;

CREATE guitar_pickups:fender_61_strat_wildwood10_middle SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  position = 'Middle',
  type = 'Single-Coil',
  model = 'Hand-Wound Wildwood 10 Strat',
  winding = NONE;

CREATE guitar_pickups:fender_61_strat_wildwood10_bridge SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  position = 'Bridge',
  type = 'Single-Coil',
  model = 'Hand-Wound Wildwood 10 Strat',
  winding = NONE;

-- Create guitar controls
CREATE guitar_controls:fender_61_strat_wildwood10_volume SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  name = 'Volume',
  detail = NONE;

CREATE guitar_controls:fender_61_strat_wildwood10_tone1 SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  name = 'Tone',
  detail = NONE;

CREATE guitar_controls:fender_61_strat_wildwood10_tone2 SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  name = 'Tone',
  detail = NONE;

CREATE guitar_controls:fender_61_strat_wildwood10_switch SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  name = '5-way Switch',
  detail = NONE;

-- Create guitar provenance
CREATE guitar_provenance:fender_61_strat_wildwood10 SET
  guitar_id = guitars:fender_61_strat_wildwood10,
  dealer_series = 'Wildwood 10',
  notes = NONE;

