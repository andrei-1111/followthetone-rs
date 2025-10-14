-- Comprehensive slug field migration
-- This migration drops, recreates, and populates the slug field

-- Step 1: Remove the existing slug field and index
REMOVE INDEX slug_idx ON guitars;
REMOVE FIELD slug ON guitars;

-- Step 2: Recreate the slug field
DEFINE FIELD slug ON guitars TYPE string;

-- Step 3: Populate slugs for each guitar individually
-- This avoids the "excessive computation depth" issue by updating records one by one

UPDATE guitars:7f8oq0nfi7neirahoxpe SET slug = "banker-58-spec-v-1958";
UPDATE guitars:cmq04skqf5ecw3vg8mvd SET slug = "banker-ironman-ct-standard";
UPDATE guitars:juxnqy7ts6x887t8dk2l SET slug = "test-unit";
UPDATE guitars:xlx55xia6b2alzxk66ft SET slug = "test2-unit";

-- Step 4: Create index on slug for faster lookups
DEFINE INDEX slug_idx ON guitars FIELDS slug UNIQUE;

-- Step 5: Verify the results
SELECT id, brand, model, year_reference, slug FROM guitars;
