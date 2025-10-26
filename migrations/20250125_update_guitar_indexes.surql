-- Migration: Update guitar indexes to allow same brand/model with different listing URLs
-- This allows multiple guitars with same brand/model as long as they have different listing URLs

-- Create a new unique index that allows same brand/model but requires unique listing URLs
DEFINE INDEX idx_guitars_brand_model_listing ON guitars COLUMNS brand, model, listing_url UNIQUE;

-- Note: The old idx_guitars_brand_model index will be automatically replaced
-- by the new index that includes listing_url in the uniqueness constraint
