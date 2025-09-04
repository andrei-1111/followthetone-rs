-- Database schema for gear_api
-- Run this in your Postgres database before starting the application

-- Create custom enum for gear types
CREATE TYPE gear_type AS ENUM ('guitar', 'effect', 'amplifier', 'accessory');

-- Create brands table
CREATE TABLE brands (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    country VARCHAR(100),
    founded_year INTEGER,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create categories table
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create gear table
CREATE TABLE gear (
    id SERIAL PRIMARY KEY,
    brand_id INTEGER REFERENCES brands(id),
    category_id INTEGER REFERENCES categories(id),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    type gear_type NOT NULL,
    year_start INTEGER,
    year_end INTEGER,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create artists table (for future use)
CREATE TABLE artists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX idx_gear_brand_id ON gear(brand_id);
CREATE INDEX idx_gear_category_id ON gear(category_id);
CREATE INDEX idx_gear_type ON gear(type);
CREATE INDEX idx_gear_slug ON gear(slug);
CREATE INDEX idx_gear_name ON gear(name);
CREATE INDEX idx_brands_name ON brands(name);

-- Insert some sample data
INSERT INTO brands (name, country, founded_year) VALUES
    ('Fender', 'USA', 1946),
    ('Gibson', 'USA', 1902),
    ('Ibanez', 'Japan', 1908),
    ('Boss', 'Japan', 1973),
    ('MXR', 'USA', 1972);

INSERT INTO categories (name, description) VALUES
    ('Electric Guitar', 'Solid body electric guitars'),
    ('Acoustic Guitar', 'Acoustic and acoustic-electric guitars'),
    ('Bass Guitar', 'Electric and acoustic bass guitars'),
    ('Distortion', 'Overdrive, distortion, and fuzz effects'),
    ('Modulation', 'Chorus, flanger, phaser effects'),
    ('Delay', 'Echo and delay effects'),
    ('Reverb', 'Reverb effects');

INSERT INTO gear (brand_id, category_id, name, slug, type, year_start, year_end, description) VALUES
    (1, 1, 'Stratocaster', 'fender-stratocaster', 'guitar', 1954, NULL, 'The iconic electric guitar with three single-coil pickups'),
    (1, 1, 'Telecaster', 'fender-telecaster', 'guitar', 1950, NULL, 'The original electric guitar with a distinctive twang'),
    (2, 1, 'Les Paul', 'gibson-les-paul', 'guitar', 1952, NULL, 'The legendary solid body electric guitar'),
    (4, 4, 'DS-1 Distortion', 'boss-ds1-distortion', 'effect', 1978, NULL, 'Classic distortion pedal used by countless guitarists'),
    (5, 4, 'Phase 90', 'mxr-phase90', 'effect', 1974, NULL, 'Iconic phaser effect pedal');
