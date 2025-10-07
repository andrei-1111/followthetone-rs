BEGIN;

-- Core guitar
WITH new_guitar AS (
  INSERT INTO guitars (brand, line, model, variant, year_reference, weight, body_style)
  VALUES (
    'Banker',
    NULL,
    'Ironman CT Standard',
    NULL,
    NULL,
    NULL,
    'Bound Double Cutaway'
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
       '1 5/8"',
       '''60 "C" Shape',
       '.91',
       '.93',
       '12"',
       NULL,
       'Jescar 45085 Nickel Silver',
       NULL                 -- binding moved to appointments
FROM new_guitar;

-- Appointments (bindings, inlays)
WITH g AS (SELECT id FROM guitars
  WHERE brand='Banker' AND model='Ironman CT Standard'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_appointments (guitar_id, binding_body, binding_fingerboard, inlays, other)
SELECT id,
       'Bound body',
       '1-Ply fingerboard binding',
       'Vintage Trapezoid',
       NULL
FROM g;

-- Woods (Honduran mahogany body + carved flame maple top)
WITH g AS (SELECT id FROM guitars
  WHERE brand='Banker' AND model='Ironman CT Standard'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_woods (guitar_id, top, body, neck, fingerboard, neck_joint, top_carve)
SELECT id,
       'Carved Flame Maple Top',
       'Honduran Mahogany',
       'Quartersawn Honduran Mahogany',
       'Rosewood',
       NULL,
       'Carved'
FROM g;

-- Finish (two color options)
WITH g AS (SELECT id FROM guitars
  WHERE brand='Banker' AND model='Ironman CT Standard'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_finish (guitar_id, color, type, aging, colors)
SELECT id,
       'Vintage Sunburst',                 -- choose one as primary display color
       'Nitrocellulose Lacquer',
       NULL,                               -- no relic/ageing specified
       ARRAY['Vintage Sunburst','Goldtop'] -- all available colors
FROM g;

-- Hardware (bridge/tailpiece, tuners, rings, notes)
WITH g AS (SELECT id FROM guitars
  WHERE brand='Banker' AND model='Ironman CT Standard'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_hardware (guitar_id, material, bridge, tailpiece, tuners, pickguard, pickup_rings, notes)
SELECT id,
       NULL,
       'Faber ABR-H',
       'Tailpiece w/ Collarless Locking Studs',
       'Grover Rotomatic',
       NULL,
       'M69 Mounting Rings',
       NULL
FROM g;

-- Setup
WITH g AS (SELECT id FROM guitars
  WHERE brand='Banker' AND model='Ironman CT Standard'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_setup (guitar_id, strings, tuning, action, nut_material, truss_rod)
SELECT id,
       'Stringjoy 10–46 Pure Nickel',
       'Standard',
       '4/64',
       'Unbleached Polished Bone',
       '2-Way Adjustable'
FROM g;

-- Case / COA not specified in the spec
WITH g AS (SELECT id FROM guitars
  WHERE brand='Banker' AND model='Ironman CT Standard'
  ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_case (guitar_id, type, coa_included, notes)
SELECT id, NULL, NULL, NULL
FROM g;

-- Pickups (Custom Throbak PAF Humbuckers)
WITH g AS (SELECT id AS guitar_id FROM guitars
  WHERE brand='Banker' AND model='Ironman CT Standard'
  ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_pickups (guitar_id, position, type, model, winding)
SELECT guitar_id, x.position, x.type, x.model, NULL
FROM g, (VALUES
  ('Neck','Humbucker','Custom Throbak PAF'),
  ('Bridge','Humbucker','Custom Throbak PAF')
) AS x(position, type, model);

-- Controls
WITH g AS (SELECT id AS guitar_id FROM guitars
  WHERE brand='Banker' AND model='Ironman CT Standard'
  ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_controls (guitar_id, name, detail)
SELECT guitar_id, x.name, x.detail
FROM g, (VALUES
  ('Volume','CTS 550k Potentiometer'),
  ('Volume','CTS 550k Potentiometer'),
  ('Tone','CTS 550k Potentiometer'),
  ('Tone','CTS 550k Potentiometer'),
  ('3-way Toggleswitch','Switchcraft')
) AS x(name, detail);

COMMIT;
