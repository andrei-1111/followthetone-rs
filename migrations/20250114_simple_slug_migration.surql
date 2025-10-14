-- Simple slug migration that avoids complex operations
-- This approach uses basic string operations to avoid computation depth issues

-- Step 1: Remove existing slug field if it exists
REMOVE FIELD slug ON guitars;

-- Step 2: Create a new slug field with a default value
DEFINE FIELD slug ON guitars TYPE string VALUE "temp-slug";

-- Step 3: Update all records with a simple approach
-- Use a basic string concatenation without complex functions
UPDATE guitars SET slug = brand + "-" + model;

-- Step 4: Show results
SELECT id, brand, model, slug FROM guitars LIMIT 3;
