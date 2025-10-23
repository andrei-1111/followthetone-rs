-- ------------------------------
-- OPTION
-- ------------------------------

-- OPTION IMPORT; -- Commented out to avoid conflicts with IF NOT EXISTS

-- ------------------------------
-- TABLE: guitar_appointments
-- ------------------------------

DEFINE TABLE IF NOT EXISTS guitar_appointments TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD IF NOT EXISTS binding_body ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS binding_fingerboard ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id ON guitar_appointments TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS headstock_veneer ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS inlays ON guitar_appointments TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS other ON guitar_appointments TYPE option<string> PERMISSIONS FULL;

DEFINE INDEX IF NOT EXISTS uniq_appointments_guitar ON guitar_appointments FIELDS guitar_id UNIQUE;


-- ------------------------------
-- TABLE DATA: guitar_appointments
-- ------------------------------

INSERT [ { binding_body: '', guitar_id: guitars:7f8oq0nfi7neirahoxpe, headstock_veneer: '', id: guitar_appointments:e4z2zlu7aftbmkkbhslf, inlays: '', other: '' }, { binding_body: 'Bound body', binding_fingerboard: '1-Ply fingerboard binding', guitar_id: guitars:cmq04skqf5ecw3vg8mvd, headstock_veneer: '', id: guitar_appointments:r88cet5wgfzms7rnybt0, inlays: 'Vintage Trapezoid', other: '' } ];

-- ------------------------------
-- TABLE: guitar_badges
-- ------------------------------

DEFINE TABLE IF NOT EXISTS guitar_badges TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD IF NOT EXISTS badge ON guitar_badges TYPE string PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id ON guitar_badges TYPE record<guitars> PERMISSIONS FULL;

DEFINE INDEX IF NOT EXISTS guitar_badges_guitar_idx ON guitar_badges FIELDS guitar_id;


-- ------------------------------
-- TABLE DATA: guitar_badges
-- ------------------------------

INSERT [ { badge: 'Wildwood Spec Badge', guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_badges:gibson_1960_les_paul_wildwood_spec } ];

-- ------------------------------
-- TABLE: guitar_case
-- ------------------------------

DEFINE TABLE IF NOT EXISTS guitar_case TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD IF NOT EXISTS coa_included ON guitar_case TYPE option<bool> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id ON guitar_case TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS notes ON guitar_case TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS type ON guitar_case TYPE option<string> PERMISSIONS FULL;

DEFINE INDEX IF NOT EXISTS uniq_case_guitar ON guitar_case FIELDS guitar_id UNIQUE;


-- ------------------------------
-- TABLE DATA: guitar_case
-- ------------------------------

INSERT [ { coa_included: true, guitar_id: guitars:7f8oq0nfi7neirahoxpe, id: guitar_case:3v5ce59wi0gy37qyno2f, notes: '', type: '' }, { guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig, id: guitar_case:45euo3urjretvairjopi, type: 'Hard Case and Gig Bag' }, { coa_included: true, guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_case:73c72sgdbp42dx3q0926, notes: '', type: 'Hard case' }, { guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case, id: guitar_case:9fopn3fqagshacrq818b, type: 'Hard Case' }, { coa_included: true, guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_case:fender_61_strat_wildwood10, type: 'Limited Edition Hardshell Case with Embroidered Custom Shop Logo' }, { coa_included: true, guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_case:gibson_1960_les_paul_wildwood_spec, type: 'Brown/Pink Lifton Reissue 5-Latch Case with Wildwood Spec Badge' } ];

-- ------------------------------
-- TABLE: guitar_controls
-- ------------------------------

DEFINE TABLE IF NOT EXISTS guitar_controls TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD IF NOT EXISTS detail ON guitar_controls TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id ON guitar_controls TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS name ON guitar_controls TYPE string PERMISSIONS FULL;

DEFINE INDEX IF NOT EXISTS idx_controls_guitar ON guitar_controls FIELDS guitar_id;


-- ------------------------------
-- TABLE DATA: guitar_controls
-- ------------------------------

INSERT [ { detail: 'CTS 550k Potentiometer', guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_controls:1e1v8l7d5doag6qrj0vj, name: 'Volume' }, { detail: 'CTS 550k Potentiometer', guitar_id: guitars:7f8oq0nfi7neirahoxpe, id: guitar_controls:3sdaos2dvjlhdq182x4g, name: 'Volume' }, { detail: 'Switchcraft', guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_controls:a8bricotxtxzkmitqw2z, name: '3-way Toggleswitch' }, { detail: 'CTS 550k Potentiometer', guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_controls:e2n3wwnw2b18cvkvljj9, name: 'Volume' }, { guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_controls:fender_61_strat_wildwood10_switch, name: '5-way Switch' }, { guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_controls:fender_61_strat_wildwood10_tone1, name: 'Tone' }, { guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_controls:fender_61_strat_wildwood10_tone2, name: 'Tone' }, { guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_controls:fender_61_strat_wildwood10_volume, name: 'Volume' }, { guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_controls:gibson_1960_les_paul_wildwood_spec_switch, name: '3-way Toggleswitch' }, { guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_controls:gibson_1960_les_paul_wildwood_spec_tone1, name: 'Tone' }, { guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_controls:gibson_1960_les_paul_wildwood_spec_tone2, name: 'Tone' }, { guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_controls:gibson_1960_les_paul_wildwood_spec_volume1, name: 'Volume' }, { guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_controls:gibson_1960_les_paul_wildwood_spec_volume2, name: 'Volume' }, { detail: 'CTS 550k Potentiometer', guitar_id: guitars:7f8oq0nfi7neirahoxpe, id: guitar_controls:lenjfqhdercgkzdfawem, name: 'Volume' }, { detail: 'CTS 550k Potentiometer', guitar_id: guitars:7f8oq0nfi7neirahoxpe, id: guitar_controls:lj5shltbn0rf813dtpoj, name: 'Tone' }, { detail: 'CTS 550k Potentiometer', guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_controls:nzp97f60393336nywp53, name: 'Tone' }, { detail: 'CTS 550k Potentiometer', guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_controls:t7pamkvn0jr9eir31mbn, name: 'Tone' }, { detail: 'Switchcraft', guitar_id: guitars:7f8oq0nfi7neirahoxpe, id: guitar_controls:wllrlhkvom80sk3l80ev, name: '3-way Toggleswitch' } ];

-- ------------------------------
-- TABLE: guitar_dimensions
-- ------------------------------

DEFINE TABLE IF NOT EXISTS guitar_dimensions TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD IF NOT EXISTS binding ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS fingerboard_radius ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS fret_count ON guitar_dimensions TYPE option<number> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS fret_type ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id ON guitar_dimensions TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS neck_profile ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS neck_thickness_12th ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS neck_thickness_1st ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS nut_width ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS scale_length ON guitar_dimensions TYPE option<string> PERMISSIONS FULL;

DEFINE INDEX IF NOT EXISTS uniq_dimensions_guitar ON guitar_dimensions FIELDS guitar_id UNIQUE;


-- ------------------------------
-- TABLE DATA: guitar_dimensions
-- ------------------------------

INSERT [ { fingerboard_radius: '12', fret_count: 22, fret_type: 'Jescar 45085 Nickel Silver', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig, id: guitar_dimensions:04cxtou6o1fyw3pjbd7i, neck_profile: '60 C Shape', neck_thickness_12th: '.93', neck_thickness_1st: '.91', nut_width: '1 5/8', scale_length: '24 3/4' }, { binding: 'Bound', fingerboard_radius: '12', fret_count: 22, fret_type: 'Jescar 45085 Nickel Silver', guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_dimensions:23qv6442lebjpg7e9mfi, neck_profile: '60 C Shape', neck_thickness_12th: '.93', neck_thickness_1st: '.91', nut_width: '1 5/8', scale_length: '24 3/4' }, { fingerboard_radius: '12', fret_count: 22, fret_type: 'Jescar 45085 Nickel Silver', guitar_id: guitars:banker_ironman_ct_custom, id: guitar_dimensions:2li91am6mnjj1529xjai, neck_profile: '60 C Shape', neck_thickness_12th: '.93', neck_thickness_1st: '.91', nut_width: '1 5/8', scale_length: '24 3/4' }, { binding: '', fingerboard_radius: '12"', fret_count: 22, fret_type: 'Jescar 45085 Nickel Silver', guitar_id: guitars:7f8oq0nfi7neirahoxpe, id: guitar_dimensions:cd14itzm1psee7l9at7g, neck_profile: "'58 D Shape", neck_thickness_12th: '.97', neck_thickness_1st: '.94', nut_width: '1 11/16"', scale_length: '24 3/4" (Vintage "Rule of 18")' }, { fingerboard_radius: '12', fret_count: 22, fret_type: 'Jescar 45085 Nickel Silver', guitar_id: guitars:banker_ironman_ct_custom_shop, id: guitar_dimensions:epy7x1ehdzppmjdl5kd3, neck_profile: '60 C Shape', neck_thickness_12th: '.93', neck_thickness_1st: '.91', nut_width: '1 5/8', scale_length: '24 3/4' }, { fingerboard_radius: 'Wildwood Custom 10"', fret_count: 21, fret_type: '6105 Narrow-Tall', guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_dimensions:fender_61_strat_wildwood10, neck_profile: '60 Oval C', neck_thickness_12th: '.940', neck_thickness_1st: '.810', nut_width: '1.650"', scale_length: '25.5"' }, { binding: '1-Ply Royalite', fingerboard_radius: '12"', fret_count: 22, fret_type: 'Authentic Medium Jumbo', guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_dimensions:gibson_1960_les_paul_wildwood_spec, neck_profile: '1960 SlimTaper', neck_thickness_12th: '.950', neck_thickness_1st: '.840', nut_width: '1.687"', scale_length: '24.75"' }, { fingerboard_radius: '12', fret_count: 22, fret_type: 'Jescar 45085 Nickel Silver', guitar_id: guitars:banker_leslie, id: guitar_dimensions:imfgbqcquvgv65aeozsx, neck_profile: "'59 \"D\" Shape", neck_thickness_12th: '.95', neck_thickness_1st: '.92', nut_width: '1 11/16', scale_length: '24 3/4' }, { fingerboard_radius: '12', fret_count: 22, fret_type: 'Jescar 45085 Nickel Silver', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe, id: guitar_dimensions:jn8q0mmyxmtc0dfkwq12, neck_profile: '60 C Shape', neck_thickness_12th: '.93', neck_thickness_1st: '.91', nut_width: '1 5/8', scale_length: '24 3/4' }, { fingerboard_radius: '12', fret_count: 22, fret_type: 'Jescar 45085 Nickel Silver', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case, id: guitar_dimensions:mox7jt019r783vie4t9b, neck_profile: '60 C Shape', neck_thickness_12th: '.93', neck_thickness_1st: '.91', nut_width: '1 5/8', scale_length: '24 3/4' }, { fingerboard_radius: '12', fret_count: 22, fret_type: 'Jescar 45085 Nickel Silver', guitar_id: guitars:banker_ironman_ct, id: guitar_dimensions:q7fb3ed7r72vz1wvyde2, neck_profile: '60 C Shape', neck_thickness_12th: '.93', neck_thickness_1st: '.91', nut_width: '1 5/8', scale_length: '24 3/4' }, { fingerboard_radius: '12', fret_count: 22, fret_type: 'Jescar 45085 Nickel Silver', guitar_id: guitars:banker_ironman_ct_deluxe, id: guitar_dimensions:t0kf3b2b4tvfsaljpyim, neck_profile: '60 C Shape', neck_thickness_12th: '.93', neck_thickness_1st: '.91', nut_width: '1 5/8', scale_length: '24 3/4' } ];

-- ------------------------------
-- TABLE: guitar_finish
-- ------------------------------

DEFINE TABLE IF NOT EXISTS guitar_finish TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD IF NOT EXISTS aging ON guitar_finish TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS color ON guitar_finish TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS colors ON guitar_finish TYPE option<array<string>> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS colors[*] ON guitar_finish TYPE string PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id ON guitar_finish TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS notes ON guitar_finish TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS type ON guitar_finish TYPE option<string> PERMISSIONS FULL;

DEFINE INDEX IF NOT EXISTS uniq_finish_guitar ON guitar_finish FIELDS guitar_id UNIQUE;


-- ------------------------------
-- TABLE DATA: guitar_finish
-- ------------------------------

INSERT [ { aging: 'Optional Aging', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case, id: guitar_finish:2e0r9s2ruduiyfoapfx7 }, { aging: 'Optional Aging', guitar_id: guitars:banker_ironman_ct_custom_shop, id: guitar_finish:6t8q5bc3w19wbq8lp7xs }, { aging: 'Optional Aging', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe, id: guitar_finish:bs09cd06jjym9o0vt6vz }, { aging: 'Optional Aging', guitar_id: guitars:banker_ironman_ct_deluxe, id: guitar_finish:cdfvowzd1gp8qn1ep32n }, { aging: 'Heavy Relic', color: 'Red Sparkle Over 3-Tone Sunburst', guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_finish:fender_61_strat_wildwood10, type: 'Nitrocellulose Lacquer' }, { aging: 'Optional Aging', guitar_id: guitars:banker_ironman_ct_custom, id: guitar_finish:fv00c9kdaoqh9o3ing0e }, { aging: 'Light Aged', color: '"Beauty of the Burst" Page 151', guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_finish:gibson_1960_les_paul_wildwood_spec, type: 'Light Aged' }, { aging: 'Aged', color: 'Natural', colors: [], guitar_id: guitars:7f8oq0nfi7neirahoxpe, id: guitar_finish:hv2os6d86zfjqaxed87z, notes: '', type: 'Nitrocellulose Lacquer' }, { aging: 'Optional Aging', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig, id: guitar_finish:ib7bkqg846dosafeony2 }, { aging: '', color: 'Vintage Sunburst', colors: ['Vintage Sunburst', 'Goldtop'], guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_finish:qn00v75xkqm62frlr1ks, notes: '', type: 'Nitrocellulose Lacquer' }, { aging: 'Optional Aging', guitar_id: guitars:banker_leslie, id: guitar_finish:t0p12lou2qqzf2b5dduq }, { aging: 'Optional Aging', guitar_id: guitars:banker_ironman_ct, id: guitar_finish:tt89h3bfg8ri2zfmchls } ];

-- ------------------------------
-- TABLE: guitar_hardware
-- ------------------------------

DEFINE TABLE IF NOT EXISTS guitar_hardware TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD IF NOT EXISTS bridge ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id ON guitar_hardware TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS material ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS notes ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS pickguard ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS pickup_rings ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS tailpiece ON guitar_hardware TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS tuners ON guitar_hardware TYPE option<string> PERMISSIONS FULL;

DEFINE INDEX IF NOT EXISTS uniq_hardware_guitar ON guitar_hardware FIELDS guitar_id UNIQUE;


-- ------------------------------
-- TABLE DATA: guitar_hardware
-- ------------------------------

INSERT [ { bridge: 'Faber Vintage Wraparound Bridge', guitar_id: guitars:banker_ironman_ct_custom, id: guitar_hardware:0vmm7x9zsm2qri2n2d77 }, { bridge: 'Faber Vintage Wraparound Bridge', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case, id: guitar_hardware:43xi1nslt97cz4qiqpsr }, { bridge: 'Faber ABR-H', guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_hardware:aondwlzu8pb91r8nbspg, material: 'Nickel', notes: '', pickguard: '', pickup_rings: 'M69 Mounting Rings', tailpiece: 'Tailpiece with Collarless Locking Studs', tuners: 'Grover Rotomatic' }, { bridge: 'Vintage Tremolo', guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_hardware:fender_61_strat_wildwood10, material: 'Nickel/Chrome', tuners: 'Vintage-Style' }, { bridge: 'No-Wire ABR-1 (Nickel-Plated Brass Saddles)', guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_hardware:gibson_1960_les_paul_wildwood_spec, material: 'Murphy Lab Light-Aged Nickel', pickguard: 'Laminated Cellulose Acetate Butyrate', tailpiece: 'Lightweight Aluminum Stopbar', tuners: 'Kluson Double-Ring Single-Line' }, { bridge: 'Faber Vintage Wraparound Bridge', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig, id: guitar_hardware:m7320f7ciur6cwcwbwv5 }, { bridge: 'Faber Vintage Wraparound Bridge', guitar_id: guitars:banker_ironman_ct, id: guitar_hardware:mrse5lqvhadt56a16mg5 }, { bridge: 'Faber Vintage Wraparound Bridge', guitar_id: guitars:banker_ironman_ct_custom_shop, id: guitar_hardware:o7brdx0r9nzf2ir1zo9r }, { bridge: 'Faber Vintage Wraparound Bridge', guitar_id: guitars:banker_ironman_ct_deluxe, id: guitar_hardware:o9tkx845k4ojs45tvvot }, { bridge: 'Faber ABR-H', guitar_id: guitars:7f8oq0nfi7neirahoxpe, id: guitar_hardware:p2cplrk8uswzs6yzq430, material: '', notes: '', pickguard: '4 Ply White', pickup_rings: '', tailpiece: 'Solid Brass "V" Tailpiece', tuners: 'Kluson Deluxe Keystone' }, { bridge: 'Faber Vintage Wraparound Bridge', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe, id: guitar_hardware:renky1d7sx6wc35cmqhf }, { bridge: 'Faber Vintage Wraparound Bridge', guitar_id: guitars:banker_leslie, id: guitar_hardware:v5mzyf7257hm5fsevrt8 } ];

-- ------------------------------
-- TABLE: guitar_pickups
-- ------------------------------

DEFINE TABLE IF NOT EXISTS guitar_pickups TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD IF NOT EXISTS guitar_id ON guitar_pickups TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS model ON guitar_pickups TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS position ON guitar_pickups TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS type ON guitar_pickups TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS winding ON guitar_pickups TYPE option<string> PERMISSIONS FULL;

DEFINE INDEX IF NOT EXISTS idx_pickups_guitar ON guitar_pickups FIELDS guitar_id;


-- ------------------------------
-- TABLE DATA: guitar_pickups
-- ------------------------------

INSERT [ { guitar_id: guitars:banker_ironman_ct_deluxe, id: guitar_pickups:6zgyculp1o6ywvw3t0tj }, { guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_pickups:88ni840wqzgets1pnvrv, model: 'Custom Throbak PAF', position: 'Bridge', type: 'Humbucker', winding: '' }, { guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_pickups:bttv84rf839q4i6x4urd, model: 'Custom Throbak PAF', position: 'Neck', type: 'Humbucker', winding: '' }, { guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_pickups:fender_61_strat_wildwood10_bridge, model: 'Hand-Wound Wildwood 10 Strat', position: 'Bridge', type: 'Single-Coil' }, { guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_pickups:fender_61_strat_wildwood10_middle, model: 'Hand-Wound Wildwood 10 Strat', position: 'Middle', type: 'Single-Coil' }, { guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_pickups:fender_61_strat_wildwood10_neck, model: 'Hand-Wound Wildwood 10 Strat', position: 'Neck', type: 'Single-Coil' }, { guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_pickups:gibson_1960_les_paul_wildwood_spec_bridge, model: 'Wildwood Spec Custombucker', position: 'Bridge', type: 'Humbucker' }, { guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_pickups:gibson_1960_les_paul_wildwood_spec_neck, model: 'Wildwood Spec Custombucker', position: 'Neck', type: 'Humbucker' }, { guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig, id: guitar_pickups:gmn1k97idzeh2pz7s9pe }, { guitar_id: guitars:banker_leslie, id: guitar_pickups:ll3zhi2ambgd73tyirvo }, { guitar_id: guitars:7f8oq0nfi7neirahoxpe, id: guitar_pickups:ol0qbw4uqk4rmss7lgwk, model: 'PAF Humbucker', position: 'Bridge', type: 'Humbucker', winding: '' }, { guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case, id: guitar_pickups:piujk8w6k3vvmxii4rbl }, { guitar_id: guitars:banker_ironman_ct, id: guitar_pickups:pxtu8ug3kemipor8d5m8 }, { guitar_id: guitars:banker_ironman_ct_custom, id: guitar_pickups:qn02o3a9kcx2idksdqi4 }, { guitar_id: guitars:7f8oq0nfi7neirahoxpe, id: guitar_pickups:r9ejabnihl8nhialch3t, model: 'PAF Humbucker', position: 'Neck', type: 'Humbucker', winding: '' }, { guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe, id: guitar_pickups:u9ls6es70zxv42dzsk88 }, { guitar_id: guitars:banker_ironman_ct_custom_shop, id: guitar_pickups:wc8q644kywp9o4ytqz33 } ];

-- ------------------------------
-- TABLE: guitar_provenance
-- ------------------------------

DEFINE TABLE IF NOT EXISTS guitar_provenance TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD IF NOT EXISTS guitar_id ON guitar_provenance TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS note ON guitar_provenance TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS url ON guitar_provenance TYPE option<string> PERMISSIONS FULL;

DEFINE INDEX IF NOT EXISTS guitar_provenance_guitar_idx ON guitar_provenance FIELDS guitar_id;


-- ------------------------------
-- TABLE DATA: guitar_provenance
-- ------------------------------

INSERT [ { guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_provenance:fender_61_strat_wildwood10 }, { guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_provenance:gibson_1960_les_paul_wildwood_spec } ];

-- ------------------------------
-- TABLE: guitar_setup
-- ------------------------------

DEFINE TABLE IF NOT EXISTS guitar_setup TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD IF NOT EXISTS action ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id ON guitar_setup TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS nut_material ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS strings ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS truss_rod ON guitar_setup TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS tuning ON guitar_setup TYPE option<string> PERMISSIONS FULL;

DEFINE INDEX IF NOT EXISTS uniq_setup_guitar ON guitar_setup FIELDS guitar_id UNIQUE;


-- ------------------------------
-- TABLE DATA: guitar_setup
-- ------------------------------

INSERT [ { action: '4/64', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case, id: guitar_setup:56hkffzqr1u96rf20d1k, strings: 'Stringjoy 10-46 Pure Nickel', tuning: 'Standard Tuning' }, { action: '4/64', guitar_id: guitars:banker_leslie, id: guitar_setup:694pbg4n05at0w4uwhd2, strings: 'Stringjoy 10-46 Pure Nickel', tuning: 'Standard Tuning' }, { action: '4/64', guitar_id: guitars:banker_ironman_ct, id: guitar_setup:982uyuio7uunkcxav57w, strings: 'Stringjoy 10-46 Pure Nickel', tuning: 'Standard Tuning' }, { action: '4/64', guitar_id: guitars:7f8oq0nfi7neirahoxpe, id: guitar_setup:cnr61nnd945zf2y95v6h, nut_material: 'Unbleached Polished Bone', strings: 'Stringjoy 10–46 Pure Nickel', truss_rod: '2-Way Adjustable', tuning: 'Standard' }, { guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_setup:fender_61_strat_wildwood10, nut_material: 'Bone' }, { action: '4/64', guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_setup:fl94w0n8cz5wnru1tjsw, nut_material: 'Unbleached Polished Bone', strings: 'Stringjoy 10-46 Pure Nickel', truss_rod: '2-Way Adjustable', tuning: 'Standard' }, { guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_setup:gibson_1960_les_paul_wildwood_spec, nut_material: 'Bone' }, { action: '4/64', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig, id: guitar_setup:hpqwf9f2n5xl0rlvfdbr, strings: 'Stringjoy 10-46 Pure Nickel', tuning: 'Standard Tuning' }, { action: '4/64', guitar_id: guitars:banker_ironman_ct_custom_shop, id: guitar_setup:l4z5vcqqpjowy66ajvei, strings: 'Stringjoy 10-46 Pure Nickel', tuning: 'Standard Tuning' }, { action: '4/64', guitar_id: guitars:banker_ironman_ct_custom, id: guitar_setup:p8qeh0r6rjplmq7sk1l7, strings: 'Stringjoy 10-46 Pure Nickel', tuning: 'Standard Tuning' }, { action: '4/64', guitar_id: guitars:banker_ironman_ct_deluxe, id: guitar_setup:t7cbf9mejqunvfc0h2qk, strings: 'Stringjoy 10-46 Pure Nickel', tuning: 'Standard Tuning' }, { action: '4/64', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe, id: guitar_setup:uszsxtnuxqasmqm7gys7, strings: 'Stringjoy 10-46 Pure Nickel', tuning: 'Standard Tuning' } ];

-- ------------------------------
-- TABLE: guitar_woods
-- ------------------------------

DEFINE TABLE IF NOT EXISTS guitar_woods TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD IF NOT EXISTS body ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS fingerboard ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id ON guitar_woods TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS neck ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS neck_joint ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS top ON guitar_woods TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS top_carve ON guitar_woods TYPE option<string> PERMISSIONS FULL;

DEFINE INDEX IF NOT EXISTS uniq_woods_guitar ON guitar_woods FIELDS guitar_id UNIQUE;


-- ------------------------------
-- TABLE DATA: guitar_woods
-- ------------------------------

INSERT [ { body: 'Honduran Mahogany or Korina', fingerboard: 'Rosewood', guitar_id: guitars:banker_ironman_ct, id: guitar_woods:336mxls16stsibcroebu, neck: 'Quartersawn Honduran Mahogany or Korina' }, { body: 'Honduran Mahogany or Korina', fingerboard: 'Rosewood', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe, id: guitar_woods:4svjc8xu1w5xepzk9hjs, neck: 'Quartersawn Honduran Mahogany or Korina' }, { body: 'Honduran Mahogany', fingerboard: 'Rosewood', guitar_id: guitars:cmq04skqf5ecw3vg8mvd, id: guitar_woods:734gpdj87tgpth8f8uah, neck: 'Quartersawn Honduran Mahogany', neck_joint: '', top: 'Carved Flame Maple Top', top_carve: 'Carved' }, { body: 'Honduran Mahogany or Korina', fingerboard: 'Rosewood', guitar_id: guitars:banker_leslie, id: guitar_woods:buaom27gvzhqb9sutr0g, neck: 'Quartersawn Honduran Mahogany or Korina' }, { body: 'Honduran Mahogany or Korina', fingerboard: 'Rosewood', guitar_id: guitars:banker_ironman_ct_custom_shop, id: guitar_woods:f0f5blib90hbfmkgwtg8, neck: 'Quartersawn Honduran Mahogany or Korina' }, { body: 'Alder', fingerboard: 'AAA Indian Rosewood', guitar_id: guitars:fender_61_strat_wildwood10, id: guitar_woods:fender_61_strat_wildwood10, neck: 'Quartersawn Maple' }, { body: '1-Piece Lightweight Mahogany', fingerboard: 'Indian Rosewood (Hot Hide Glue)', guitar_id: guitars:gibson_1960_les_paul_wildwood_spec, id: guitar_woods:gibson_1960_les_paul_wildwood_spec, neck: 'Solid Mahogany', neck_joint: 'Long Tenon with Hide Glue Fit', top: '2-Piece Hand-Picked Figured Maple (Hot Hide Glue)' }, { body: 'Korina', fingerboard: 'Rosewood', guitar_id: guitars:7f8oq0nfi7neirahoxpe, id: guitar_woods:honw09aqxlec95vrssjo, neck: 'Quartersawn Korina', neck_joint: '', top: '', top_carve: '' }, { body: 'Honduran Mahogany or Korina', fingerboard: 'Rosewood', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig, id: guitar_woods:l5cx57hv6iq462yv482q, neck: 'Quartersawn Honduran Mahogany or Korina' }, { body: 'Honduran Mahogany or Korina', fingerboard: 'Rosewood', guitar_id: guitars:banker_ironman_ct_deluxe, id: guitar_woods:nylqkxu4a6l6ln1udtjp, neck: 'Quartersawn Honduran Mahogany or Korina' }, { body: 'Honduran Mahogany or Korina', fingerboard: 'Rosewood', guitar_id: guitars:banker_ironman_ct_custom, id: guitar_woods:tytgwxbrbwzx5xtfxgkh, neck: 'Quartersawn Honduran Mahogany or Korina' }, { body: 'Honduran Mahogany or Korina', fingerboard: 'Rosewood', guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case, id: guitar_woods:w1dbonydvmybpena8y6b, neck: 'Quartersawn Honduran Mahogany or Korina' } ];

-- ------------------------------
-- TABLE: guitars
-- ------------------------------

DEFINE TABLE IF NOT EXISTS guitars TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;

DEFINE FIELD IF NOT EXISTS auction ON guitars TYPE option<bool> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS body_style ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS brand ON guitars TYPE string ASSERT $value != '' PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS categories ON guitars TYPE option<array<string>> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS categories[*] ON guitars TYPE string PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS condition_display ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS condition_slug ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS created_at ON guitars TYPE datetime VALUE time::now() PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS created_at_market ON guitars TYPE option<datetime> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS description_html ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS display_title ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS external_id ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS external_source ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS finish_display ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS has_inventory ON guitars TYPE option<bool> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS hero_url ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS inventory ON guitars TYPE option<number> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS line ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS listing_currency ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS listing_url ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS model ON guitars TYPE string ASSERT $value != '' PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS offers_enabled ON guitars TYPE option<bool> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS published_at ON guitars TYPE option<datetime> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS shop_id ON guitars TYPE option<number> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS shop_name ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS shop_slug ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS slug ON guitars TYPE string PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS updated_at ON guitars TYPE datetime VALUE time::now() PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS variant ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS weight ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS year_reference ON guitars TYPE option<string> PERMISSIONS FULL;

DEFINE INDEX IF NOT EXISTS guitars_ext_unique ON guitars FIELDS external_source, external_id UNIQUE;
DEFINE INDEX IF NOT EXISTS idx_guitars_brand_model ON guitars FIELDS brand, model UNIQUE;
DEFINE INDEX IF NOT EXISTS slug_idx ON guitars FIELDS slug UNIQUE;


-- ------------------------------
-- TABLE DATA: guitars
-- ------------------------------

INSERT [ { body_style: 'Double Cut', brand: 'Banker', created_at: d'2025-10-20T14:12:57.987230343Z', id: guitars:0gq0pkosgy7tj8mu0sqf, line: 'Solidbody Electric', model: 'Ironman', slug: 'banker-ironman', updated_at: d'2025-10-20T14:12:57.987263793Z', variant: '', weight: '', year_reference: '' }, { body_style: 'Double Cut, Redwood Top', brand: 'Banker', created_at: d'2025-10-20T14:13:06.134374471Z', id: guitars:4ljrpu8ar3d6p9zkbga1, line: 'Solidbody Electric', model: 'Redtail', slug: 'banker-redtail', updated_at: d'2025-10-20T14:13:06.134409541Z', variant: '', weight: '', year_reference: '' }, { body_style: 'V Neck-thru', brand: 'Banker', created_at: d'2025-10-20T14:13:03.627924898Z', id: guitars:7blfaxck4as6ucu85wrb, line: 'Solidbody Electric', model: 'V Bird', slug: 'banker-v-bird', updated_at: d'2025-10-20T14:13:03.627960128Z', variant: '', weight: '', year_reference: '' }, { body_style: 'V', brand: 'Banker', created_at: d'2025-10-15T14:29:45.150871475Z', id: guitars:7f8oq0nfi7neirahoxpe, line: '', model: "58' Spec V", slug: 'banker-58-spec-v', updated_at: d'2025-10-15T14:29:45.150997575Z', variant: '', weight: '', year_reference: '1958' }, { body_style: 'Reverse, Neck-thru', brand: 'Banker', created_at: d'2025-10-20T14:13:08.787863982Z', id: guitars:9r8yofslbv3h4npc4o4m, line: 'Solidbody Electric', model: 'Redtail R', slug: 'banker-redtail-r', updated_at: d'2025-10-20T14:13:08.787890402Z', variant: '', weight: '', year_reference: '' }, { body_style: 'Bound Double Cutaway', brand: 'Banker', created_at: d'2025-10-20T14:15:58.224633691Z', id: guitars:banker_ironman_ct_custom, line: 'Solidbody Electric', model: 'Ironman CT Custom', slug: 'ironman-ct-custom', updated_at: d'2025-10-20T14:15:58.224658761Z' }, { body_style: 'Bound Double Cutaway', brand: 'Banker', created_at: d'2025-10-20T14:15:59.153978395Z', id: guitars:banker_ironman_ct_custom_shop, line: 'Solidbody Electric', model: 'Ironman CT Custom Shop', slug: 'ironman-ct-custom-shop', updated_at: d'2025-10-20T14:15:59.154016295Z' }, { body_style: 'Bound Double Cutaway', brand: 'Banker', created_at: d'2025-10-20T14:16:00.079329725Z', id: guitars:banker_ironman_ct_custom_shop_deluxe, line: 'Solidbody Electric', model: 'Ironman CT Custom Shop Deluxe', slug: 'ironman-ct-custom-shop-deluxe', updated_at: d'2025-10-20T14:16:00.079365825Z' }, { body_style: 'Bound Double Cutaway', brand: 'Banker', created_at: d'2025-10-20T14:16:01.013433771Z', id: guitars:banker_ironman_ct_custom_shop_deluxe_case, line: 'Solidbody Electric', model: 'Ironman CT Custom Shop Deluxe with Case', slug: 'ironman-ct-custom-shop-deluxe-case', updated_at: d'2025-10-20T14:16:01.013460521Z' }, { body_style: 'Bound Double Cutaway', brand: 'Banker', created_at: d'2025-10-20T14:16:02.088810965Z', id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig, line: 'Solidbody Electric', model: 'Ironman CT Custom Shop Deluxe with Case and Gig Bag', slug: 'ironman-ct-custom-shop-deluxe-case-gig', updated_at: d'2025-10-20T14:16:02.088847525Z' }, { body_style: 'Bound Double Cutaway', brand: 'Banker', created_at: d'2025-10-20T14:15:57.309198518Z', id: guitars:banker_ironman_ct_deluxe, line: 'Solidbody Electric', model: 'Ironman CT Deluxe', slug: 'ironman-ct-deluxe', updated_at: d'2025-10-20T14:15:57.309224138Z' }, { body_style: 'Bound Double Cutaway', brand: 'Banker', created_at: d'2025-10-15T14:29:45.164735194Z', id: guitars:cmq04skqf5ecw3vg8mvd, line: '', model: 'Ironman CT Standard', slug: 'banker-ironman-ct-standard', updated_at: d'2025-10-15T14:29:45.164754444Z', variant: '', weight: '', year_reference: '' }, { body_style: 'Stratocaster', brand: 'Fender Custom Shop', created_at: d'2025-10-15T14:29:45.164947304Z', id: guitars:fender_61_strat_wildwood10, line: 'Dealer Select Wildwood 10', model: '61 Strat', slug: 'fender-custom-shop-61-strat-wildwood10', updated_at: d'2025-10-15T14:29:45.164956684Z', variant: 'Red Sparkle Over 3-Tone Sunburst', weight: '7.30 lbs.', year_reference: '1961' }, { body_style: 'Flying V', brand: 'Banker', created_at: d'2025-10-20T14:13:01.617993798Z', id: guitars:g4xrvtwfrio5b1km11sv, line: 'Solidbody Electric', model: "'58 Korina V", slug: 'banker-58-korina-v', updated_at: d'2025-10-20T14:13:01.618021608Z', variant: '', weight: '', year_reference: '1958' }, { body_style: 'Semi-Hollow', brand: 'Banker', created_at: d'2025-10-20T14:13:11.005950365Z', id: guitars:gaza9vkh2v2chvyyosfu, line: 'Semi-Hollow Electric', model: 'Demonbreun', slug: 'banker-demonbreun', updated_at: d'2025-10-20T14:13:11.005986885Z', variant: '', weight: '', year_reference: '' }, { body_style: 'Slab Single/Double Cut', brand: 'Banker', created_at: d'2025-10-20T14:12:55.801717582Z', id: guitars:gh9ihbk3iap4hkqvc4i0, line: 'Solidbody Electric', model: 'Leslie', slug: 'banker-leslie', updated_at: d'2025-10-20T14:12:55.801768252Z', variant: '', weight: '', year_reference: '' }, { body_style: 'Les Paul', brand: 'Gibson Murphy Lab', created_at: d'2025-10-15T14:29:45.165029394Z', id: guitars:gibson_1960_les_paul_wildwood_spec, line: 'Murphy Lab', model: 'Wildwood Spec 1960 Les Paul Standard', slug: 'gibson-murphy-lab-wildwood-spec-1960-les-paul-standard', updated_at: d'2025-10-15T14:29:45.165038934Z', variant: '"Beauty of the Burst" Page 151', weight: '8.51 lbs.', year_reference: '1960' }, { body_style: 'Explorer', brand: 'Banker', created_at: d'2025-10-20T14:13:00.118180641Z', id: guitars:ogtqji2ris42hijscgvt, line: 'Solidbody Electric', model: "'58 Korina Excalibur", slug: 'banker-58-korina-excalibur', updated_at: d'2025-10-20T14:13:00.118206691Z', variant: '', weight: '', year_reference: '1958' }, { body_style: 'Bass, Neck-thru', brand: 'Banker', created_at: d'2025-10-20T14:13:16.445726966Z', id: guitars:oz2ftogo3zbbfdqv09pn, line: 'Bass & Baritone', model: 'Dirty Bird', slug: 'banker-dirty-bird', updated_at: d'2025-10-20T14:13:16.445753556Z', variant: '', weight: '', year_reference: '' }, { body_style: 'Semi-Hollow', brand: 'Banker', created_at: d'2025-10-20T14:13:14.021856291Z', id: guitars:vgleh8m95n2w74iteor2, line: 'Semi-Hollow Electric', model: 'El Dorado', slug: 'banker-el-dorado', updated_at: d'2025-10-20T14:13:14.021880621Z', variant: '', weight: '', year_reference: '' } ];

