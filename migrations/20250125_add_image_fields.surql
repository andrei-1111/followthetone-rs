-- Migration: Add image fields for scraped website URLs
-- This adds fields to store hero image and image gallery URLs from scraped websites

-- Add hero image URL field (rename existing hero_url to hero_image_url for consistency)
DEFINE FIELD hero_image_url ON guitars TYPE option<string> PERMISSIONS FULL;

-- Add image gallery array field
DEFINE FIELD image_gallery ON guitars TYPE option<array<string>> PERMISSIONS FULL;
DEFINE FIELD image_gallery[*] ON guitars TYPE string PERMISSIONS FULL;

-- Add image source field to track where images came from
DEFINE FIELD image_source ON guitars TYPE option<string> PERMISSIONS FULL;

-- Add condition and status fields for dealer listings
DEFINE FIELD condition ON guitars TYPE option<string> PERMISSIONS FULL;
DEFINE FIELD status ON guitars TYPE option<string> PERMISSIONS FULL;

-- Add production year fields for comparison features
DEFINE FIELD production_year ON guitars TYPE option<number> PERMISSIONS FULL;
DEFINE FIELD spec_version_year ON guitars TYPE option<number> PERMISSIONS FULL;
