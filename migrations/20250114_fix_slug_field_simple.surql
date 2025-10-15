-- Simple slug field fix migration
-- Since we have no duplicates, we can skip the complex duplicate handling

-- Step 0: Remove the recursive event that's causing infinite loops
REMOVE EVENT guitars_touch ON TABLE guitars;

-- Step 1: Make slug optional so NONE values are acceptable
DEFINE FIELD slug ON TABLE guitars TYPE option<string>;

-- Step 2: Backfill slug values (no recursion now that event is removed)
UPDATE guitars SET slug = string::slug(brand + "-" + model) WHERE slug = NONE;

-- Step 3: Create the UNIQUE index (one-line rule)
DEFINE INDEX slug_idx ON TABLE guitars FIELDS slug UNIQUE;

-- Step 4: Verify results
SELECT id, brand, model, slug FROM guitars;

