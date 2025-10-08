-- Core guitar (capture id)
LET $g = (CREATE guitars CONTENT { brand: "Banker", model: "Ironman CT Standard", body_style: "Bound Double Cutaway", line: "", variant: "", year_reference: "", weight: "", price_cents: 0, price_currency: "USD", serial_number: "" } RETURN AFTER);

-- Dimensions / specs
CREATE guitar_dimensions CONTENT { guitar_id: $g.id, scale_length: "24 3/4", nut_width: "1 5/8", neck_profile: "60 C Shape", neck_thickness_1st: ".91", neck_thickness_12th: ".93", fingerboard_radius: "12", fret_count: 22, fret_type: "Jescar 45085 Nickel Silver", binding: "Bound" };

-- Appointments
CREATE guitar_appointments CONTENT { guitar_id: $g.id, binding_body: "Bound body", binding_fingerboard: "1-Ply fingerboard binding", inlays: "Vintage Trapezoid", headstock_veneer: "", other: "" };

-- Woods
CREATE guitar_woods CONTENT { guitar_id: $g.id, top: "Carved Flame Maple Top", body: "Honduran Mahogany", neck: "Quartersawn Honduran Mahogany", fingerboard: "Rosewood", neck_joint: "", top_carve: "Carved" };

-- Finish
CREATE guitar_finish CONTENT { guitar_id: $g.id, color: "Vintage Sunburst", type: "Nitrocellulose Lacquer", aging: "", colors: ["Vintage Sunburst","Goldtop"], notes: "" };

-- Hardware
CREATE guitar_hardware CONTENT { guitar_id: $g.id, material: "Nickel", bridge: "Faber ABR-H", tailpiece: "Tailpiece with Collarless Locking Studs", tuners: "Grover Rotomatic", pickguard: "", pickup_rings: "M69 Mounting Rings", notes: "" };

-- Setup
CREATE guitar_setup CONTENT { guitar_id: $g.id, strings: "Stringjoy 10-46 Pure Nickel", tuning: "Standard", action: "4/64", nut_material: "Unbleached Polished Bone", truss_rod: "2-Way Adjustable" };

-- Case / COA
CREATE guitar_case CONTENT { guitar_id: $g.id, type: "Hard case", coa_included: true, notes: "" };

-- Pickups (2x)
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Neck", type: "Humbucker", model: "Custom Throbak PAF", winding: "" };
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Bridge", type: "Humbucker", model: "Custom Throbak PAF", winding: "" };

-- Controls (5x)
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Volume", detail: "CTS 550k Potentiometer" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Volume", detail: "CTS 550k Potentiometer" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", detail: "CTS 550k Potentiometer" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", detail: "CTS 550k Potentiometer" };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "3-way Toggleswitch", detail: "Switchcraft" };
