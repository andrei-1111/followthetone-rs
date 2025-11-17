-- Clean up duplicate records for V Custom guitar
-- Get the V Custom guitar ID
LET $v_custom_id = (SELECT id FROM guitars WHERE brand = "Banker" AND model = "V Custom" LIMIT 1)[0].id;

-- Delete all existing pickups and controls for V Custom
DELETE guitar_pickups WHERE guitar_id = $v_custom_id;
DELETE guitar_controls WHERE guitar_id = $v_custom_id;

-- Recreate the correct pickups (2 total)
CREATE guitar_pickups CONTENT {
  guitar_id: $v_custom_id,
  position: "Bridge",
  type: "Humbucker",
  model: "PAF Humbucker",
  winding: ""
};

CREATE guitar_pickups CONTENT {
  guitar_id: $v_custom_id,
  position: "Neck",
  type: "Humbucker",
  model: "PAF Humbucker",
  winding: ""
};

-- Recreate the correct controls (4 total)
CREATE guitar_controls CONTENT {
  guitar_id: $v_custom_id,
  name: "Volume",
  detail: "CTS 550k Potentiometer"
};

CREATE guitar_controls CONTENT {
  guitar_id: $v_custom_id,
  name: "Volume",
  detail: "CTS 550k Potentiometer"
};

CREATE guitar_controls CONTENT {
  guitar_id: $v_custom_id,
  name: "Tone",
  detail: "CTS 550k Potentiometer"
};

CREATE guitar_controls CONTENT {
  guitar_id: $v_custom_id,
  name: "3-way Switch",
  detail: "Switchcraft 3 Way"
};

-- Update V Custom price
UPDATE guitars SET price_cents = 549900, price_currency = "USD" WHERE brand = "Banker" AND model = "V Custom";

-- Summary
SELECT count() AS pickup_count FROM guitar_pickups WHERE guitar_id = $v_custom_id;
SELECT count() AS control_count FROM guitar_controls WHERE guitar_id = $v_custom_id;
