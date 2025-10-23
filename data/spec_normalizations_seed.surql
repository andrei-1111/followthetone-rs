-- Seed data for spec_normalizations table
-- Common guitar specification normalizations for comparison feature

-- Neck Profile Normalizations
INSERT INTO spec_normalizations (category, raw_value, normalized_value, unit, notes) VALUES
('neck_profile', '60s SlimTaper', 'SlimTaper 60', null, 'Gibson neck profile'),
('neck_profile', '1960 SlimTaper', 'SlimTaper 60', null, 'Gibson neck profile'),
('neck_profile', 'SlimTaper 60', 'SlimTaper 60', null, 'Gibson neck profile'),
('neck_profile', 'SlimTaper 60s', 'SlimTaper 60', null, 'Gibson neck profile'),
('neck_profile', '60 C Shape', 'C Shape 60', null, 'Fender neck profile'),
('neck_profile', '60 Oval C', 'C Shape 60', null, 'Fender neck profile'),
('neck_profile', 'Vintage C', 'C Shape 60', null, 'Fender neck profile'),
('neck_profile', 'Modern C', 'C Shape Modern', null, 'Fender neck profile'),
('neck_profile', 'U Shape', 'U Shape', null, 'Fender neck profile'),
('neck_profile', 'D Shape', 'D Shape', null, 'Fender neck profile'),
('neck_profile', 'Soft V', 'V Shape Soft', null, 'Fender neck profile'),
('neck_profile', 'Hard V', 'V Shape Hard', null, 'Fender neck profile'),
('neck_profile', 'Baseball Bat', 'U Shape', null, 'Gibson neck profile'),
('neck_profile', 'Chunky', 'U Shape', null, 'Gibson neck profile'),
('neck_profile', 'Slim', 'SlimTaper 60', null, 'Generic slim profile'),
('neck_profile', 'Thick', 'U Shape', null, 'Generic thick profile');

-- Scale Length Normalizations
INSERT INTO spec_normalizations (category, raw_value, normalized_value, unit, notes) VALUES
('scale_length', '24 3/4', '24.75', 'in', 'Gibson standard'),
('scale_length', '24.75', '24.75', 'in', 'Gibson standard'),
('scale_length', '24 3/4"', '24.75', 'in', 'Gibson standard'),
('scale_length', '24.75"', '24.75', 'in', 'Gibson standard'),
('scale_length', '24 3/4 (Vintage "Rule of 18")', '24.75', 'in', 'Gibson vintage'),
('scale_length', '25.5', '25.5', 'in', 'Fender standard'),
('scale_length', '25.5"', '25.5', 'in', 'Fender standard'),
('scale_length', '25', '25', 'in', 'Gibson short scale'),
('scale_length', '25"', '25', 'in', 'Gibson short scale'),
('scale_length', '24', '24', 'in', 'Gibson short scale'),
('scale_length', '24"', '24', 'in', 'Gibson short scale'),
('scale_length', '26.5', '26.5', 'in', 'Baritone scale'),
('scale_length', '26.5"', '26.5', 'in', 'Baritone scale'),
('scale_length', '27', '27', 'in', 'Baritone scale'),
('scale_length', '27"', '27', 'in', 'Baritone scale');

-- Nut Width Normalizations
INSERT INTO spec_normalizations (category, raw_value, normalized_value, unit, notes) VALUES
('nut_width', '1 5/8', '1.625', 'in', 'Fender standard'),
('nut_width', '1.625', '1.625', 'in', 'Fender standard'),
('nut_width', '1 5/8"', '1.625', 'in', 'Fender standard'),
('nut_width', '1.625"', '1.625', 'in', 'Fender standard'),
('nut_width', '1 11/16', '1.6875', 'in', 'Gibson standard'),
('nut_width', '1.6875', '1.6875', 'in', 'Gibson standard'),
('nut_width', '1 11/16"', '1.6875', 'in', 'Gibson standard'),
('nut_width', '1.6875"', '1.6875', 'in', 'Gibson standard'),
('nut_width', '1 3/4', '1.75', 'in', 'Wide nut'),
('nut_width', '1.75', '1.75', 'in', 'Wide nut'),
('nut_width', '1 3/4"', '1.75', 'in', 'Wide nut'),
('nut_width', '1.75"', '1.75', 'in', 'Wide nut'),
('nut_width', '1 9/16', '1.5625', 'in', 'Narrow nut'),
('nut_width', '1.5625', '1.5625', 'in', 'Narrow nut'),
('nut_width', '1 9/16"', '1.5625', 'in', 'Narrow nut'),
('nut_width', '1.5625"', '1.5625', 'in', 'Narrow nut');

-- Fingerboard Radius Normalizations
INSERT INTO spec_normalizations (category, raw_value, normalized_value, unit, notes) VALUES
('fingerboard_radius', '12', '12', 'in', 'Gibson standard'),
('fingerboard_radius', '12"', '12', 'in', 'Gibson standard'),
('fingerboard_radius', '7.25', '7.25', 'in', 'Fender vintage'),
('fingerboard_radius', '7.25"', '7.25', 'in', 'Fender vintage'),
('fingerboard_radius', '9.5', '9.5', 'in', 'Fender modern'),
('fingerboard_radius', '9.5"', '9.5', 'in', 'Fender modern'),
('fingerboard_radius', '10', '10', 'in', 'Fender custom'),
('fingerboard_radius', '10"', '10', 'in', 'Fender custom'),
('fingerboard_radius', '15', '15', 'in', 'Gibson modern'),
('fingerboard_radius', '15"', '15', 'in', 'Gibson modern'),
('fingerboard_radius', '16', '16', 'in', 'Gibson modern'),
('fingerboard_radius', '16"', '16', 'in', 'Gibson modern');

-- Weight Normalizations (convert to pounds)
INSERT INTO spec_normalizations (category, raw_value, normalized_value, unit, notes) VALUES
('weight', '7.30 lbs.', '7.30', 'lbs', 'Standard weight'),
('weight', '7.30 lbs', '7.30', 'lbs', 'Standard weight'),
('weight', '8.51 lbs.', '8.51', 'lbs', 'Heavy weight'),
('weight', '8.51 lbs', '8.51', 'lbs', 'Heavy weight'),
('weight', '6.5 lbs.', '6.5', 'lbs', 'Light weight'),
('weight', '6.5 lbs', '6.5', 'lbs', 'Light weight'),
('weight', '3.3 kg', '7.28', 'lbs', 'Metric to imperial'),
('weight', '3.5 kg', '7.72', 'lbs', 'Metric to imperial'),
('weight', '4.0 kg', '8.82', 'lbs', 'Metric to imperial');

-- Bridge Type Normalizations
INSERT INTO spec_normalizations (category, raw_value, normalized_value, unit, notes) VALUES
('bridge', 'Faber Vintage Wraparound Bridge', 'Wraparound Bridge', null, 'Vintage style'),
('bridge', 'Faber ABR-H', 'ABR-1 Bridge', null, 'Gibson style'),
('bridge', 'ABR-1', 'ABR-1 Bridge', null, 'Gibson style'),
('bridge', 'No-Wire ABR-1', 'ABR-1 Bridge', null, 'Gibson style'),
('bridge', 'Vintage Tremolo', 'Tremolo Bridge', null, 'Fender style'),
('bridge', 'Tune-o-matic', 'Tune-o-matic', null, 'Gibson style'),
('bridge', 'TOM', 'Tune-o-matic', null, 'Gibson style'),
('bridge', 'Fixed Bridge', 'Fixed Bridge', null, 'Generic fixed'),
('bridge', 'Hardtail', 'Fixed Bridge', null, 'Fender style');

-- Pickup Type Normalizations
INSERT INTO spec_normalizations (category, raw_value, normalized_value, unit, notes) VALUES
('pickup_type', 'Humbucker', 'Humbucker', null, 'Dual coil'),
('pickup_type', 'Single-Coil', 'Single-Coil', null, 'Single coil'),
('pickup_type', 'P-90', 'P-90', null, 'Gibson single coil'),
('pickup_type', 'PAF', 'Humbucker', null, 'Gibson humbucker'),
('pickup_type', 'Custombucker', 'Humbucker', null, 'Gibson custom humbucker'),
('pickup_type', 'Throbak PAF', 'Humbucker', null, 'Vintage style humbucker'),
('pickup_type', 'Wildwood Spec Custombucker', 'Humbucker', null, 'Custom humbucker');
