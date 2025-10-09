-- Banker 58' Spec V — SurrealDB seed (corrected quoting and balanced blocks)
LET $brand = 'Banker';
LET $model = '58\' Spec V';
LET $body_style = 'V';
LET $line = '';
LET $variant = '';
LET $serial = '';

-- Find or create the guitar
LET $found = (SELECT id, created_at FROM guitars WHERE brand = $brand AND model = $model ORDER BY created_at DESC LIMIT 1);
LET $g = (
  IF array::len($found) = 0 THEN (
    CREATE guitars CONTENT {
      brand: $brand,
      line:  $line,
      model: $model,
      variant: $variant,
      year_reference: '1958',
      body_style: $body_style,
      weight: '',
      serial_number: $serial
    } RETURN AFTER
  ) ELSE $found[0] END
);

-- Clear existing children to avoid duplicates when re-running
DELETE FROM guitar_dimensions WHERE guitar_id = $g.id;
DELETE FROM guitar_appointments WHERE guitar_id = $g.id;
DELETE FROM guitar_woods       WHERE guitar_id = $g.id;
DELETE FROM guitar_finish      WHERE guitar_id = $g.id;
DELETE FROM guitar_hardware    WHERE guitar_id = $g.id;
DELETE FROM guitar_setup       WHERE guitar_id = $g.id;
DELETE FROM guitar_case        WHERE guitar_id = $g.id;
DELETE FROM guitar_pickups     WHERE guitar_id = $g.id;
DELETE FROM guitar_controls    WHERE guitar_id = $g.id;

-- Children
CREATE guitar_dimensions CONTENT {
  guitar_id: $g.id,
  scale_length: '24 3/4" (Vintage "Rule of 18")',
  nut_width: '1 11/16"',
  neck_profile: "'58 D Shape",
  neck_thickness_1st: '.94',
  neck_thickness_12th: '.97',
  fingerboard_radius: '12"',
  fret_count: 22,
  fret_type: 'Jescar 45085 Nickel Silver',
  binding: ''
};

CREATE guitar_appointments CONTENT {
  guitar_id: $g.id,
  binding_body: '',
  binding_neck: '',
  binding_headstock: '',
  side_dots: '',
  fingerboard: '',
  inlays: '',
  headstock_veneer: '',
  other: ''
};

CREATE guitar_woods CONTENT {
  guitar_id: $g.id,
  top: '',
  body: 'Korina',
  neck: 'Quartersawn Korina',
  fingerboard: 'Rosewood',
  neck_joint: '',
  top_carve: ''
};

CREATE guitar_finish CONTENT {
  guitar_id: $g.id,
  color: 'Natural',
  type: 'Nitrocellulose Lacquer',
  aging: 'Aged',
  colors: [],
  notes: ''
};

CREATE guitar_hardware CONTENT {
  guitar_id: $g.id,
  material: '',
  bridge: 'Faber ABR-H',
  tailpiece: 'Solid Brass "V" Tailpiece',
  tuners: 'Kluson Deluxe Keystone',
  pickguard: '4 Ply White',
  pickup_rings: '',
  notes: ''
};

CREATE guitar_setup CONTENT {
  guitar_id: $g.id,
  strings: 'Stringjoy 10–46 Pure Nickel',
  tuning: 'Standard',
  action: '4/64',
  nut_material: 'Unbleached Polished Bone',
  truss_rod: '2-Way Adjustable'
};

CREATE guitar_case CONTENT {
  guitar_id: $g.id,
  type: '',
  coa_included: true,
  notes: ''
};

CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: 'Neck',   type: 'Humbucker', model: 'PAF Humbucker', winding: '' };
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: 'Bridge', type: 'Humbucker', model: 'PAF Humbucker', winding: '' };

CREATE guitar_controls CONTENT { guitar_id: $g.id, name: 'Volume', detail: 'CTS 550k Potentiometer' };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: 'Volume', detail: 'CTS 550k Potentiometer' };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: 'Tone', detail: 'CTS 550k Potentiometer' };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: '3-way Toggleswitch', detail: 'Switchcraft' };

-- Summary (optional)
SELECT id, brand, model FROM guitars WHERE id = $g.id;
SELECT count() AS pickup_count FROM guitar_pickups WHERE guitar_id = $g.id;
SELECT count() AS control_count FROM guitar_controls WHERE guitar_id = $g.id;
