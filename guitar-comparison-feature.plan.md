# Guitar Comparison Feature Implementation

## Schema Updates

### Add New Fields to `guitars` Table

Add these fields via SurrealDB migration to support better comparison identity:

- `production_year` (INT) - actual build year of the specific guitar example
- `spec_version_year` (INT) - catalog/spec year for reissue comparisons (e.g., '58 Reissue made in 2021 has spec_version_year: 1958, production_year: 2021)

### Create Normalization Mapping Table

Create `spec_normalizations` table to store canonical terminology mappings:

- Neck profiles: "60s SlimTaper", "1960 SlimTaper", "SlimTaper 60" → "SlimTaper 60"
- Scale lengths: "24 3/4", "24.75", "24 3/4 (Vintage Rule of 18)" → 24.75
- Other common variations

## Backend Implementation

### 1. Models (`src/models.rs`)

Add these new structs:

- `GuitarComparisonRequest` - request DTO accepting 2-4 guitar IDs/slugs
- `GuitarComparison` - complete response with all spec tables joined
- `ComparisonField` - individual field with value + diff indicator
- `NormalizedValue` - holds raw + normalized value + unit
- `SpecNormalization` - mapping model for normalization table

Update `Guitar` struct to include new fields: `production_year`, `spec_version_year`

### 2. Comparison Logic (`src/comparison.rs` - new file)

Create dedicated module with:

**Core functions:**

- `fetch_guitars_for_comparison()` - fetches 2-4 guitars with ALL related tables (dimensions, woods, finish, hardware, pickups, controls, setup, appointments, badges, provenance, case)
- `normalize_spec_value()` - applies normalization rules (neck profiles, scale lengths, measurements)
- `convert_units()` - handles in↔mm, lbs↔kg conversions
- `calculate_diffs()` - marks fields where values differ across guitars
- `apply_paywall_restrictions()` - truncates/blurs fields for non-subscribers

**Normalization helpers:**

- `normalize_neck_profile()` - maps neck profile variations to canonical names
- `normalize_scale_length()` - converts to decimal inches (24.75)
- `normalize_measurement()` - extracts numeric value + unit, converts as needed
- `parse_weight()` - handles "7.30 lbs", "3.3 kg" → normalized format

**Diff calculation:**

- Group guitars by comparable identity (brand + model + spec_version_year)
- Highlight differences in each field
- Flag missing data vs actual differences

### 3. Routes (`src/routes.rs`)

Add new endpoint:

```rust
#[get("/api/compare")]
async fn compare_guitars(
    db: web::Data<Surreal<Client>>,
    query: web::Query<CompareQuery>,
    // auth: Option<web::Data<AuthContext>> // for paywall
) -> impl Responder
```

Query parameters:

- `ids` or `slugs` - comma-separated list of 2-4 guitar identifiers
- `format` - optional (json, compact) for different response formats
- Example: `/api/compare?slugs=banker-leslie,banker-ironman-ct-standard,fender-custom-shop-61-strat-wildwood10`

Response structure:

```json
{
  "guitars": [
    {"id": "guitars:xxx", "brand": "...", "model": "...", ...},
    ...
  ],
  "comparison_grid": {
    "dimensions": {
      "scale_length": [
        {"guitar_id": "guitars:xxx", "raw": "24 3/4", "normalized": "24.75 in", "unit": "in", "differs": false},
        ...
      ],
      "neck_profile": [
        {"guitar_id": "guitars:xxx", "raw": "60s SlimTaper", "normalized": "SlimTaper 60", "differs": true},
        ...
      ]
    },
    "woods": {...},
    "finish": {...},
    "hardware": {...},
    "electronics": {
      "pickups": [...],
      "controls": [...]
    },
    "setup": {...},
    "provenance": {...}
  },
  "metadata": {
    "compare_url": "/compare?slugs=...",
    "paywall_applied": false,
    "cached": true
  }
}
```

### 4. Caching Strategy

- Use simple in-memory cache with TTL (5 min) for comparison results
- Cache key: sorted guitar IDs
- Optional: Redis for production if needed

### 5. Database Migration

Create `migrations/20250123_add_comparison_fields.surql`:

- ALTER guitars table to add production_year, spec_version_year
- CREATE spec_normalizations table
- Seed common normalizations (neck profiles, scale lengths)

## Data Seeding

Create `data/spec_normalizations_seed.surql` with common mappings:

- Neck profiles: ~20-30 common variations
- Scale lengths: standard values (24.75, 25.5, 25, etc.)
- Measurements: fractional to decimal conversions

## Testing

Create test endpoints or scripts:

- Compare same model different years (e.g., multiple Banker Leslie variants)
- Compare different models (Les Paul vs Strat)
- Test normalization accuracy
- Verify performance (<500ms for 4 guitars)

## Performance Targets

- Fetch all data for 4 guitars in 1-2 queries (use JOIN or parallel fetch)
- Normalization/diff calculation: <50ms
- Total server time: <500ms
- Consider: batch fetch all related tables in single query using SurrealDB FETCH

## Key Files to Modify

1. `src/models.rs` - add 5-6 new structs
2. `src/comparison.rs` - NEW file (~400-500 lines)
3. `src/routes.rs` - add compare_guitars endpoint
4. `migrations/20250123_add_comparison_fields.surql` - NEW
5. `data/spec_normalizations_seed.surql` - NEW
6. `.cursorrules` - document comparison API patterns

## To-dos

- [ ] Create migration to add production_year and spec_version_year fields to guitars table, and create spec_normalizations table
- [ ] Create seed data for common spec normalizations (neck profiles, scale lengths, measurements)
- [ ] Add comparison-related structs to models.rs (ComparisonRequest, ComparisonResponse, ComparisonField, NormalizedValue, etc.)
- [ ] Implement comparison.rs module with fetch, normalize, diff, and paywall logic
- [ ] Add /api/compare endpoint to routes.rs that orchestrates the comparison flow
- [ ] Implement unit conversion helpers (inches/mm, lbs/kg) in comparison.rs
- [ ] Test comparison endpoint with various guitar combinations and verify performance
- [ ] Document comparison API patterns and usage in .cursorrules
