BEGIN;

-- Core guitar
WITH new_guitar AS (
  INSERT INTO guitars (brand, line, model, variant, year_reference, weight)
  VALUES (
    'Banker',
    NULL,
    '58'' Spec V',                         -- 58' Spec V
    NULL,
    '1958',
    NULL                                    -- price not modeled here
  )
  RETURNING id
)
-- Dimensions
INSERT INTO guitar_dimensions (
  guitar_id, scale_length, nut_width, neck_profile, neck_thickness_1st,
  neck_thickness_12th, fingerboard_radius, fret_count, fret_type, binding
)
SELECT id,
       '24 3/4" (Vintage "Rule of 18")',
       '1 11/16"',
       '''58 "D" Shape',                    -- leading apostrophe escaped
       '.94',
       '.97',
       '12"',
       NULL,
       'Jescar 45085 Nickel Silver',
       NULL
FROM new_guitar;

-- Woods
WITH g AS (SELECT id FROM guitars
  WHERE brand='Banker' AND model='58'' Spec V'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_woods (guitar_id, top, body, neck, fingerboard, neck_joint)
SELECT id,
       NULL,
       'Korina',
       'Quartersawn Korina',
       'Rosewood',
       NULL
FROM g;

-- Finish
WITH g AS (SELECT id FROM guitars
  WHERE brand='Banker' AND model='58'' Spec V'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_finish (guitar_id, color, type, aging)
SELECT id,
       'Natural',
       'Nitrocellulose Lacquer',
       'Aged'
FROM g;

-- Hardware
WITH g AS (SELECT id FROM guitars
  WHERE brand='Banker' AND model='58'' Spec V'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_hardware (guitar_id, material, bridge, tailpiece, tuners, pickguard)
SELECT id,
       NULL,
       'Faber ABR-H',
       'Solid Brass "V" Tailpiece',
       'Kluson Deluxe Keystone',
       '4 Ply White'
FROM g;

-- Setup
WITH g AS (SELECT id FROM guitars
  WHERE brand='Banker' AND model='58'' Spec V'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_setup (guitar_id, strings, tuning, action, nut_material, truss_rod)
SELECT id,
       'Stringjoy 10–46 Pure Nickel',
       'Standard',
       '4/64',
       'Unbleached Polished Bone',
       '2-Way Adjustable'
FROM g;

-- Case (not specified)
WITH g AS (SELECT id FROM guitars
  WHERE brand='Banker' AND model='58'' Spec V'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_case (guitar_id, type, coa_included, notes)
SELECT id, NULL, NULL, NULL
FROM g;

-- Pickups
WITH g AS (SELECT id AS guitar_id FROM guitars
  WHERE brand='Banker' AND model='58'' Spec V'
  ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_pickups (guitar_id, position, type, model, winding)
SELECT guitar_id, x.position, x.type, x.model, NULL
FROM g, (VALUES
  ('Neck','Humbucker','PAF Humbucker'),
  ('Bridge','Humbucker','PAF Humbucker')
) AS x(position, type, model);

-- Controls
WITH g AS (SELECT id AS guitar_id FROM guitars
  WHERE brand='Banker' AND model='58'' Spec V'
  ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_controls (guitar_id, name, detail)
SELECT guitar_id, x.name, x.detail
FROM g, (VALUES
  ('Volume','CTS 550k Potentiometer'),
  ('Volume','CTS 550k Potentiometer'),
  ('Tone','CTS 550k Potentiometer'),
  ('3-way Toggleswitch','Switchcraft')
) AS x(name, detail);

COMMIT;
