BEGIN;

WITH new_guitar AS (
  INSERT INTO guitars (brand, line, model, variant, year_reference, weight)
  VALUES (
    'Fender Custom Shop',
    'Dealer Select Wildwood 10',
    '''61 Strat',
    'Red Sparkle Over 3-Tone Sunburst',
    '1961',
    '7.30 lbs.'
  )
  RETURNING id
)
INSERT INTO guitar_dimensions (
  guitar_id, scale_length, nut_width, neck_profile, neck_thickness_1st,
  neck_thickness_12th, fingerboard_radius, fret_count, fret_type, binding
)
SELECT id, '25.5"', '1.650"', '''60 Oval C', '.810', '.940', 'Wildwood Custom 10"', 21,
       '6105 Narrow-Tall', NULL
FROM new_guitar;

WITH g AS (SELECT id FROM guitars
  WHERE brand='Fender Custom Shop' AND model='''61 Strat'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_woods (guitar_id, top, body, neck, fingerboard, neck_joint)
SELECT id, NULL, 'Alder', 'Quartersawn Maple', 'AAA Indian Rosewood', NULL
FROM g;

WITH g AS (SELECT id FROM guitars
  WHERE brand='Fender Custom Shop' AND model='''61 Strat'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_finish (guitar_id, color, type, aging)
SELECT id, 'Red Sparkle Over 3-Tone Sunburst', 'Nitrocellulose Lacquer', 'Heavy Relic'
FROM g;

WITH g AS (SELECT id FROM guitars
  WHERE brand='Fender Custom Shop' AND model='''61 Strat'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_hardware (guitar_id, material, bridge, tailpiece, tuners, pickguard)
SELECT id, 'Nickel/Chrome', 'Vintage Tremolo', NULL, 'Vintage-Style', NULL
FROM g;

WITH g AS (SELECT id FROM guitars
  WHERE brand='Fender Custom Shop' AND model='''61 Strat'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_setup (guitar_id, strings, tuning, action, nut_material, truss_rod)
SELECT id, NULL, NULL, NULL, 'Bone', NULL
FROM g;

WITH g AS (SELECT id FROM guitars
  WHERE brand='Fender Custom Shop' AND model='''61 Strat'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_case (guitar_id, type, coa_included, notes)
SELECT id, 'Limited Edition Hardshell Case with Embroidered Custom Shop Logo', TRUE, NULL
FROM g;

-- Pickups
WITH g AS (SELECT id AS guitar_id FROM guitars
  WHERE brand='Fender Custom Shop' AND model='''61 Strat'
  ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_pickups (guitar_id, position, type, model, winding)
SELECT guitar_id, x.position, x.type, x.model, NULL
FROM g, (VALUES
  ('Neck','Single-Coil','Hand-Wound Wildwood 10 Strat'),
  ('Middle','Single-Coil','Hand-Wound Wildwood 10 Strat'),
  ('Bridge','Single-Coil','Hand-Wound Wildwood 10 Strat')
) AS x(position, type, model);

-- Controls
WITH g AS (SELECT id AS guitar_id FROM guitars
  WHERE brand='Fender Custom Shop' AND model='''61 Strat'
  ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_controls (guitar_id, name, detail)
SELECT guitar_id, x.name, x.detail
FROM g, (VALUES
  ('Volume',NULL), ('Tone',NULL), ('Tone',NULL), ('5-way Switch',NULL)
) AS x(name, detail);

-- Provenance (optional)
WITH g AS (SELECT id AS guitar_id FROM guitars
  WHERE brand='Fender Custom Shop' AND model='''61 Strat'
  ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_provenance (guitar_id, dealer_series, notes)
SELECT guitar_id, 'Wildwood 10', NULL FROM g;

COMMIT;
