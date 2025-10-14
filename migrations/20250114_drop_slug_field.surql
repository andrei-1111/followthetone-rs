-- Drop slug field migration
-- This removes the slug field and its index from the guitars table

-- Step 1: Remove the slug index
REMOVE INDEX slug_idx ON guitars;

-- Step 2: Remove the slug field
REMOVE FIELD slug ON guitars;

-- Step 3: Verify the field has been removed
SELECT id, brand, model, year_reference FROM guitars LIMIT 3;
