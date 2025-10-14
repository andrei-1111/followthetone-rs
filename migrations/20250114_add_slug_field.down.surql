-- Remove slug field and index
REMOVE INDEX slug_idx ON guitars;
REMOVE FIELD slug ON guitars;
