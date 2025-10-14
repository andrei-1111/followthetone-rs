-- Complete slug field fix migration
-- Fixes recursive events, type mismatches, and unique constraints

-- Step 0: Remove the recursive event that's causing infinite loops
REMOVE EVENT guitars_touch ON TABLE guitars;

-- Step 1: Make slug optional so NONE values are acceptable
DEFINE FIELD slug ON TABLE guitars TYPE option<string>;

-- Step 2: Backfill slug values (no recursion now that event is removed)
UPDATE guitars SET slug = string::slug(brand + "-" + model) WHERE slug = NONE;

-- Step 3: Check for duplicate slugs
SELECT slug, count() AS c FROM guitars GROUP BY slug ORDER BY c DESC;

-- Step 4: Fix any duplicate slugs by appending ID suffix (using string::slice on id directly)
UPDATE guitars SET slug = string::slug(brand + "-" + model) + "-" + string::slice(id, -6)
WHERE slug IN (SELECT slug FROM guitars GROUP BY slug HAVING count() > 1);

-- Step 5: Create the UNIQUE index (one-line rule)
DEFINE INDEX slug_idx ON TABLE guitars FIELDS slug UNIQUE;

-- Step 6: Verify results
SELECT id, brand, model, slug FROM guitars;