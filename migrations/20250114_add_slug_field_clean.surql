-- Clean slug field migration
-- This adds the slug field without trying to populate it
-- The Rust backend will generate slugs on-the-fly when needed

-- Step 1: Add the slug field
DEFINE FIELD slug ON guitars TYPE string;

-- Step 2: Create index on slug for faster lookups (optional)
DEFINE INDEX slug_idx ON guitars FIELDS slug UNIQUE;

-- Step 3: Verify the field has been added
INFO FOR TABLE guitars;
