BEGIN;

-- Core
WITH g AS (
  INSERT INTO guitars (
    brand, line, model, variant, year_reference, weight,
    body_style, price_cents, price_currency, serial_number
  ) VALUES (
    'Nik Huber', NULL, 'Orca 59', 'Brazilian Ice Tea Burst (55086)', NULL,
    NULL,                         -- weight not provided
    NULL,                         -- singlecut; leave NULL or 'Single Cut'
    993923, 'USD', '55086'
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
       '24.75"',
       '1.67" (42.5 mm)',
       'Orca Standard',
       NULL, NULL,
       'Compound 10"–14"',
       22,
       'Medium Jumbo (extra hard)',
       NULL
FROM g;

-- Appointments
WITH g2 AS (SELECT id FROM guitars WHERE brand='Nik Huber' AND model='Orca 59' ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_appointments (guitar_id, binding_body, binding_fingerboard, inlays, headstock_veneer, other)
SELECT id,
       NULL,                           -- listing doesn’t specify body binding
       NULL,
       'Crown MOP',
       'Ebony veneer',
       'Body shape: Orca 59 (Fat Back)'
FROM g2;

-- Woods
WITH g3 AS (SELECT id FROM guitars WHERE brand='Nik Huber' AND model='Orca 59' ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_woods (guitar_id, top, body, neck, fingerboard, neck_joint, top_carve)
SELECT id,
       'Exceptional 5A Curly Maple (upgrade)',
       'Mahogany',
       'Mahogany',
       'Super Dark Brazilian Rosewood (upgrade)',
       NULL,
       NULL
FROM g3;

-- Finish
WITH g4 AS (SELECT id FROM guitars WHERE brand='Nik Huber' AND model='Orca 59' ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_finish (guitar_id, color, type, aging, notes)
SELECT id,
       'Ice Tea Burst',
       'Gloss',
       NULL,
       'Finish & top listed as upgrades'
FROM g4;

-- Hardware
WITH g5 AS (SELECT id FROM guitars WHERE brand='Nik Huber' AND model='Orca 59' ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_hardware (guitar_id, material, bridge, tailpiece, tuners, pickguard, pickup_rings, notes)
SELECT id,
       'Nickel',
       'ABM AVR-2',
       'Aluminum Tailpiece',
       'Nik Huber 510 Open Gear',
       NULL,
       NULL,
       NULL
FROM g5;

-- Setup
WITH g6 AS (SELECT id FROM guitars WHERE brand='Nik Huber' AND model='Orca 59' ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_setup (guitar_id, strings, tuning, action, nut_material, truss_rod)
SELECT id,
       NULL,
       NULL,
       NULL,
       NULL,              -- nut width given; material not stated
       NULL
FROM g6;

-- Case
WITH g7 AS (SELECT id FROM guitars WHERE brand='Nik Huber' AND model='Orca 59' ORDER BY id DESC LIMIT 1)
INSERT INTO guitar_case (guitar_id, type, coa_included, notes)
SELECT id,
       'Deluxe Hard Case',
       NULL,
       NULL
FROM g7;

-- Pickups (Häussel 1959 Humbuckers, aged nickel covers)
WITH g8 AS (SELECT id AS guitar_id FROM guitars WHERE brand='Nik Huber' AND model='Orca 59' ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_pickups (guitar_id, position, type, model, winding)
SELECT guitar_id, v.position, v.type, v.model, NULL
FROM g8, (VALUES
  ('Neck','Humbucker','Häussel 1959 (Aged Nickel Cover)'),
  ('Bridge','Humbucker','Häussel 1959 (Aged Nickel Cover)')
) AS v(position, type, model);

-- Controls (3-way, 2V/2T, coil tap)
WITH g9 AS (SELECT id AS guitar_id FROM guitars WHERE brand='Nik Huber' AND model='Orca 59' ORDER BY guitar_id DESC LIMIT 1)
INSERT INTO guitar_controls (guitar_id, name, detail)
SELECT guitar_id, v.name, v.detail
FROM g9, (VALUES
  ('Volume','Neck'),
  ('Volume','Bridge'),
  ('Tone','Neck (push/pull coil tap)'),
  ('Tone','Bridge (push/pull coil tap)'),
  ('3-way Toggleswitch',NULL)
) AS v(name, detail);

COMMIT;
