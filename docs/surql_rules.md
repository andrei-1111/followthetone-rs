# SurrealDB Script Rules - FollowTheTone

## Overview
These rules are based on successful patterns from `schema_only.surql` and `banker-seed.surql` files that work correctly with SurrealDB 2.3.10.

## Schema Definition Rules

### 1. Table Definitions
```sql
-- ✅ CORRECT: Use IF NOT EXISTS for all table definitions
DEFINE TABLE IF NOT EXISTS table_name TYPE NORMAL SCHEMAFULL PERMISSIONS FULL;
```

### 2. Field Definitions
```sql
-- ✅ CORRECT: Use IF NOT EXISTS for all field definitions
DEFINE FIELD IF NOT EXISTS field_name ON table_name TYPE field_type PERMISSIONS FULL;

-- Examples:
DEFINE FIELD IF NOT EXISTS slug ON guitars TYPE string PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS guitar_id ON guitar_dimensions TYPE record<guitars> PERMISSIONS FULL;
DEFINE FIELD IF NOT EXISTS colors ON guitar_finish TYPE option<array<string>> PERMISSIONS FULL;
```

### 3. Index Definitions
```sql
-- ✅ CORRECT: Use IF NOT EXISTS for all index definitions
DEFINE INDEX IF NOT EXISTS index_name ON table_name FIELDS field_name UNIQUE;
DEFINE INDEX IF NOT EXISTS index_name ON table_name FIELDS field_name;
```

### 4. Required Fields
- **`guitars` table**: Must include `slug` field (required, not optional)
- **All foreign keys**: Must be `record<parent_table>` type
- **Array fields**: Use `option<array<type>>` for optional arrays

## Data Import Rules

### 1. Variable Assignment Pattern
```sql
-- ✅ CORRECT: Capture created record ID for foreign key relationships
LET $variable = (CREATE table_name CONTENT { ... } RETURN AFTER)[0];
```

**Key Points:**
- Use `[0]` to get the first record from `RETURN AFTER` array
- Store in variable for use in related records
- Variable name should be descriptive (e.g., `$g` for guitar)

### 2. Foreign Key Relationships
```sql
-- ✅ CORRECT: Use captured variable for foreign keys
CREATE related_table CONTENT {
  parent_id: $variable.id,  -- Use .id property
  other_field: "value"
};
```

### 3. Duplicate Prevention
```sql
-- ✅ CORRECT: Use unique identifiers to avoid duplicates
CREATE guitars CONTENT {
  brand: "Brand",
  model: "Unique Model Name",  -- Must be unique
  slug: "unique-slug"         -- Must be unique
};
```

**Strategies:**
- Use unique model names (e.g., "Model Test", "Model Seed")
- Use unique slugs (e.g., "model-test", "model-seed")
- Consider timestamps or UUIDs for uniqueness

### 4. Required Field Handling
```sql
-- ✅ CORRECT: Always include required fields
CREATE guitars CONTENT {
  brand: "Brand",           -- Required string
  model: "Model",           -- Required string
  slug: "unique-slug",      -- Required string
  // ... other fields
};
```

## File Organization Rules

### 1. Schema-Only Files
- **Purpose**: Define database structure only
- **Pattern**: Use `IF NOT EXISTS` for all definitions
- **Content**: Only `DEFINE TABLE`, `DEFINE FIELD`, `DEFINE INDEX`
- **No Data**: No `CREATE`, `INSERT`, or `UPDATE` statements

### 2. Data Import Files
- **Purpose**: Insert/update data records
- **Pattern**: Use variables to capture record IDs
- **Content**: `CREATE` statements with proper foreign key relationships
- **No Schema**: No `DEFINE` statements

### 3. Mixed Files (Avoid)
- **Problem**: Schema + data in same file causes conflicts
- **Solution**: Separate into `schema_only.surql` and `data_seed.surql`

## Common Patterns

### 1. Guitar Creation Pattern
```sql
-- Step 1: Create main guitar record
LET $g = (CREATE guitars CONTENT {
  brand: "Brand",
  model: "Unique Model Name",
  slug: "unique-slug",
  // ... other required fields
} RETURN AFTER)[0];

-- Step 2: Create related records
CREATE guitar_dimensions CONTENT { guitar_id: $g.id, ... };
CREATE guitar_appointments CONTENT { guitar_id: $g.id, ... };
CREATE guitar_woods CONTENT { guitar_id: $g.id, ... };
// ... etc
```

### 2. Multiple Related Records
```sql
-- For one-to-many relationships (e.g., pickups, controls)
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Neck", ... };
CREATE guitar_pickups CONTENT { guitar_id: $g.id, position: "Bridge", ... };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Volume", ... };
CREATE guitar_controls CONTENT { guitar_id: $g.id, name: "Tone", ... };
```

## Error Prevention

### 1. Common Errors to Avoid
- ❌ Missing `slug` field in `guitars` table
- ❌ Using `$variable` instead of `$variable.id` for foreign keys
- ❌ Not using `[0]` with `RETURN AFTER`
- ❌ Duplicate brand/model combinations
- ❌ Missing `IF NOT EXISTS` in schema definitions

### 2. Testing Strategy
- Test schema-only files first
- Test data import files separately
- Use unique identifiers to avoid conflicts
- Check for required fields before running

## File Naming Conventions

- `schema_only.surql` - Pure schema definitions
- `data_seed.surql` - Data import scripts
- `migration_YYYYMMDD_description.surql` - Schema migrations
- `run_script_name.sh` - Shell scripts to execute SurQL files

## Execution Commands

### Schema Migration
```bash
surreal sql --conn "https://$SURREAL_URL" --user "$SURREAL_USER" --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" --db "$SURREAL_DB" \
  < data/schema_only.surql
```

### Data Import
```bash
surreal sql --conn "https://$SURREAL_URL" --user "$SURREAL_USER" --pass "$SURREAL_PASS" \
  --ns "$SURREAL_NS" --db "$SURREAL_DB" \
  < data/data_seed.surql
```

## Success Indicators

### Schema Files
- ✅ No parse errors
- ✅ No "already exists" errors
- ✅ All tables/fields/indexes created or skipped gracefully

### Data Import Files
- ✅ No "NONE for field" errors
- ✅ Foreign key relationships work correctly
- ✅ All related records created successfully
- ✅ No duplicate constraint violations
