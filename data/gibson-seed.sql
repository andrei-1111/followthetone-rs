BEGIN;

WITH new_guitar AS (
  INSERT INTO guitars (brand, line, model, variant, year_reference, weight)
  VALUES (
    'Gibson Murphy Lab',
    'Murphy Lab',
    'Wildwood Spec 1960 Les Paul Standard',
    '"Beauty of the Burst" Page 151',
    '1960',
    '8.51 lbs.'
  )
  RETURNING id
)
INSERT INTO guitar_dimensions (
  guitar_id, scale_length, nut_width, neck_profile, neck_thickness_1st,
  neck_thickness_12th, fingerboard_radius, fret_count, fret_type, binding
)
SELECT id, '24.75"', '1.687"', '1960 SlimTaper', '.840', '.950', '12"', 22,
       'Authentic Medium Jumbo', '1-Ply Royalite'
FROM new_guitar;

WITH new_guitar AS (SELECT id FROM guitars
  WHERE brand='Gibson Murphy Lab' AND model='Wildwood Spec 1960 Les Paul Standard'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_woods (guitar_id, top, body, neck, fingerboard, neck_joint)
SELECT id,
       '2-Piece Hand-Picked Figured Maple (Hot Hide Glue)',
       '1-Piece Lightweight Mahogany',
       'Solid Mahogany',
       'Indian Rosewood (Hot Hide Glue)',
       'Long Tenon with Hide Glue Fit'
FROM new_guitar;

WITH new_guitar AS (SELECT id FROM guitars
  WHERE brand='Gibson Murphy Lab' AND model='Wildwood Spec 1960 Les Paul Standard'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_finish (guitar_id, color, type, aging)
SELECT id, '"Beauty of the Burst" Page 151', 'Light Aged', 'Light Aged'
FROM new_guitar;

WITH new_guitar AS (SELECT id FROM guitars
  WHERE brand='Gibson Murphy Lab' AND model='Wildwood Spec 1960 Les Paul Standard'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_hardware (guitar_id, material, bridge, tailpiece, tuners, pickguard)
SELECT id,
       'Murphy Lab Light-Aged Nickel',
       'No-Wire ABR-1 (Nickel-Plated Brass Saddles)',
       'Lightweight Aluminum Stopbar',
       'Kluson Double-Ring Single-Line',
       'Laminated Cellulose Acetate Butyrate'
FROM new_guitar;

WITH new_guitar AS (SELECT id FROM guitars
  WHERE brand='Gibson Murphy Lab' AND model='Wildwood Spec 1960 Les Paul Standard'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_setup (guitar_id, strings, tuning, action, nut_material, truss_rod)
SELECT id, NULL, NULL, NULL, 'Bone', NULL
FROM new_guitar;

WITH new_guitar AS (SELECT id FROM guitars
  WHERE brand='Gibson Murphy Lab' AND model='Wildwood Spec 1960 Les Paul Standard'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_case (guitar_id, type, coa_included, notes)
SELECT id,
       'Brown/Pink Lifton Reissue 5-Latch Case with Wildwood Spec Badge',
       TRUE, NULL
FROM new_guitar;

-- Electronics: pickups
WITH g AS (SELECT id AS guitar_id FROM guitars
  WHERE brand='Gibson Murphy Lab' AND model='Wildwood Spec 1960 Les Paul Standard'
  ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_pickups (guitar_id, position, type, model, winding)
SELECT guitar_id, x.position, x.type, x.model, NULL
FROM g, (VALUES
  ('Neck','Humbucker','Wildwood Spec Custombucker'),
  ('Bridge','Humbucker','Wildwood Spec Custombucker')
) AS x(position, type, model);

-- Electronics: controls
WITH g AS (SELECT id AS guitar_id FROM guitars
  WHERE brand='Gibson Murphy Lab' AND model='Wildwood Spec 1960 Les Paul Standard'
  ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_controls (guitar_id, name, detail)
SELECT guitar_id, x.name, x.detail
FROM g, (VALUES
  ('Volume',NULL), ('Volume',NULL), ('Tone',NULL), ('Tone',NULL),
  ('3-way Toggleswitch',NULL)
) AS x(name, detail);

-- Provenance + badges
WITH g AS (SELECT id AS guitar_id FROM guitars
  WHERE brand='Gibson Murphy Lab' AND model='Wildwood Spec 1960 Les Paul Standard'
  ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_provenance (guitar_id, dealer_series, notes)
SELECT guitar_id, 'Wildwood Spec', NULL FROM g;

WITH g AS (SELECT id AS guitar_id FROM guitars
  WHERE brand='Gibson Murphy Lab' AND model='Wildwood Spec 1960 Les Paul Standard'
  ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_badges (guitar_id, badge)
SELECT guitar_id, 'Wildwood Spec Badge' FROM g;

COMMIT;
