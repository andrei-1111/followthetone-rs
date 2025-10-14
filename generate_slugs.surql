-- Generate slugs for existing guitars
-- This script creates URL-friendly slugs from brand, model, and year

UPDATE guitars SET slug = string::slugify(brand + "-" + model + "-" + year_reference) WHERE slug = NONE;

-- Show the results
SELECT id, brand, model, year_reference, slug FROM guitars;
