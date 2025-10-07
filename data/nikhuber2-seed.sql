BEGIN;

-- Core
WITH g AS (
  INSERT INTO guitars (
    brand, line, model, variant, year_reference, weight,
    body_style, price_cents, price_currency, serial_number
  ) VALUES (
    'Nik Huber', NULL, 'Krautster III', 'Copper Top', NULL,
    '6 lbs 14 oz',
    NULL,                      -- no explicit style beyond singlecut; leave NULL or set 'Single Cut'
    434500, 'USD', '44749'
  )
  RETURNING id
)

-- Dimensions
INSERT INTO guitar_dimensions (
  guitar_id, scale_length, nut_width, neck_profile,
  neck_thickness_1st, neck_thickness_12th,
  fingerboard_radius, fret_count, fret_type, binding
)
SELECT id,
       '25.5" (635 mm)',
       '1 5/8"',
       '''60 "C" Shape',
       '.91', '.93',
       'Compound 10"–14" (255–355 mm)',
       22,
       'Medium Jumbo, extra hard (2.49 mm W × 1.19 mm H), routed slots',
       NULL
FROM g;

-- Appointments
WITH g2 AS (SELECT id FROM guitars WHERE brand='Nik Huber' AND model='Krautster III' ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_appointments (guitar_id, binding_body, binding_fingerboard, inlays, headstock_veneer, other)
SELECT id,
       'Cream front binding',
       NULL,
       'Bone dot fingerboard inlays',
       'Ebony',
       'Black brushed bell knobs; Black brushed switch tip'
FROM g2;

-- Woods
WITH g3 AS (SELECT id FROM guitars WHERE brand='Nik Huber' AND model='Krautster III' ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_woods (guitar_id, top, body, neck, fingerboard, neck_joint, top_carve)
SELECT id,
       'Copper top (finish over cap)',             -- treat as top surface; Huber does copper-topped variants
       'Spanish Cedar',
       'Flame Maple',
       'East Indian Rosewood',
       NULL,
       NULL
FROM g3;

-- Finish
WITH g4 AS (SELECT id FROM guitars WHERE brand='Nik Huber' AND model='Krautster III' ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_finish (guitar_id, color, type, aging, notes)
SELECT id, 'Copper Top', 'Satin', NULL, NULL
FROM g4;

-- Hardware
WITH g5 AS (SELECT id FROM guitars WHERE brand='Nik Huber' AND model='Krautster III' ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_hardware (guitar_id, material, bridge, tailpiece, tuners, pickguard, pickup_rings, notes)
SELECT id,
       'Nickel',                                     -- common; adjust if you have the exact spec
       'Nick Huber Stop Tail Bridge',                -- stop tail (combined bridge/tail)
       NULL,
       'Nick Huber 510 Open Gear (Tulip Buttons)',
       NULL,
       NULL,
       NULL
FROM g5;

-- Setup
WITH g6 AS (SELECT id FROM guitars WHERE brand='Nik Huber' AND model='Krautster III' ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_setup (guitar_id, strings, tuning, action, nut_material, truss_rod)
SELECT id,
       '010–046',
       NULL,
       NULL,
       'Bone',
       'Double-action (single rod, compressed)'
FROM g6;

-- Case
WITH g7 AS (SELECT id FROM guitars WHERE brand='Nik Huber' AND model='Krautster III' ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_case (guitar_id, type, coa_included, notes)
SELECT id, 'Hard Case', NULL, NULL
FROM g7;

-- Pickups
WITH g8 AS (SELECT id AS guitar_id FROM guitars WHERE brand='Nik Huber' AND model='Krautster III' ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_pickups (guitar_id, position, type, model, winding)
SELECT guitar_id, v.position, v.type, v.model, NULL
FROM g8, (VALUES
  ('Neck','P90','Custom P90 "1956"'),
  ('Bridge','Humbucker','Krautster-B (H. Häussel) w/ aged nickel cover')
) AS v(position, type, model);

-- Controls
WITH g9 AS (SELECT id AS guitar_id FROM guitars WHERE brand='Nik Huber' AND model='Krautster III' ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_controls (guitar_id, name, detail)
SELECT guitar_id, v.name, v.detail
FROM g9, (VALUES
  ('Volume','Master'),
  ('Tone','Master (push/pull coil tap)'),
  ('3-way Toggleswitch',NULL)
) AS v(name, detail);

COMMIT;
