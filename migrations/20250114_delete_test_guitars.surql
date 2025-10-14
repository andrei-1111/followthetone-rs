-- Delete test guitar records migration
-- This removes the test guitars that are no longer needed

DELETE guitars:xlx55xia6b2alzxk66ft;
DELETE guitars:juxnqy7ts6x887t8dk2l;

-- Verify the records have been deleted
SELECT id, brand, model FROM guitars;
