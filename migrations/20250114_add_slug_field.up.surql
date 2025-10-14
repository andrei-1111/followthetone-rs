-- Add slug field to guitars table
DEFINE FIELD slug ON guitars TYPE string;

-- Update existing guitars with slug values (using string::slug instead of slugify)
UPDATE guitars SET slug = string::slug(brand + "-" + model + "-" + year_reference) WHERE slug = NONE;

-- Create index on slug for faster lookups
DEFINE INDEX slug_idx ON guitars FIELDS slug UNIQUE;
