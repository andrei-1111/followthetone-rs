-- params (edit these 6 values)
LET $brand = "Brand"; LET $model = "Model"; LET $body_style = "Body"; LET $line = ""; LET $variant = ""; LET $serial = "";

-- find or create guitar (include created_at in projection since we ORDER BY it)
LET $found = (SELECT id, created_at FROM guitars WHERE brand = $brand AND model = $model ORDER BY created_at DESC LIMIT 1);
LET $g = (IF array::len($found) = 0 THEN (CREATE guitars CONTENT { brand: $brand, model: $model, body_style: $body_style, line: $line, variant: $variant, year_reference: "", weight: "", price_cents: 0, price_currency: "USD", serial_number: $serial } RETURN AFTER) ELSE $found[0] END);

-- clear existing children to avoid dupes
DELETE FROM guitar_dimensions WHERE guitar_id = $g.id; DELETE FROM guitar_appointments WHERE guitar_id = $g.id; DELETE FROM guitar_woods WHERE guitar_id = $g.id; DELETE FROM guitar_finish WHERE guitar_id = $g.id; DELETE FROM guitar_hardware WHERE guitar_id = $g.id; DELETE FROM guitar_setup WHERE guitar_id = $g.id; DELETE FROM guitar_case WHERE guitar_id = $g.id; DELETE FROM guitar_pickups WHERE guitar_id = $g.id; DELETE FROM guitar_controls WHERE guitar_id = $g.id;

-- add children (edit freely; all fields optional in your schema)
CREATE guitar_dimensions CONTENT { guitar_id: $g.id, scale_length: "", nut_width: "", neck_profile: "", fingerboard_radius: "", fret_count: 22, fret_type: "", binding: "" };
CREATE guitar_appointments CONTENT { guitar_id: $g.id, binding_body: "", binding_fingerboard: "", inlays: "", headstock_veneer: "", other: "" };
CREATE guitar_woods        CONTENT { guitar_id: $g.id, top: "", body: "", neck: "", fingerboard: "", neck_joint: "", top_carve: "" };
CREATE guitar_finish       CONTENT { guitar_id: $g.id, color: "", type: "", aging: "", colors: [], notes: "" };
CREATE guitar_hardware     CONTENT { guitar_id: $g.id, material: "", bridge: "", tailpiece: "", tuners: "", pickguard: "", pickup_rings: "", notes: "" };
CREATE guitar_setup        CONTENT { guitar_id: $g.id, strings: "", tuning: "", action: "", nut_material: "", truss_rod: "" };
CREATE guitar_case         CONTENT { guitar_id: $g.id, type: "", coa_included: true, notes: "" };
CREATE guitar_pickups      CONTENT { guitar_id: $g.id, position: "Neck",   type: "Humbucker", model: "", winding: "" };
CREATE guitar_pickups      CONTENT { guitar_id: $g.id, position: "Bridge", type: "Humbucker", model: "", winding: "" };
CREATE guitar_controls     CONTENT { guitar_id: $g.id, name: "Volume", detail: "" }; CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Volume", detail: "" }; CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", detail: "" }; CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", detail: "" }; CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "3-way Toggleswitch", detail: "" };

-- summary
SELECT id, brand, model FROM guitars WHERE id = $g.id; SELECT count() AS dim_count FROM guitar_dimensions WHERE guitar_id = $g.id; SELECT count() AS pickup_count FROM guitar_pickups WHERE guitar_id = $g.id; SELECT count() AS control_count FROM guitar_controls WHERE guitar_id = $g.id;
