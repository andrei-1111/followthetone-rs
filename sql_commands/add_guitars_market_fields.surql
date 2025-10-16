-- Extend guitars table with marketplace import fields (from guitars.json)

-- Identifiers / source mapping
DEFINE FIELD IF NOT EXISTS external_source     ON TABLE guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS external_id         ON TABLE guitars TYPE option<string>;
DEFINE INDEX IF NOT EXISTS guitars_ext_unique  ON TABLE guitars COLUMNS external_source, external_id UNIQUE;

-- Marketplace links
DEFINE FIELD IF NOT EXISTS listing_url         ON TABLE guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS hero_url            ON TABLE guitars TYPE option<string>;

-- Display / text
DEFINE FIELD IF NOT EXISTS display_title       ON TABLE guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS description_html    ON TABLE guitars TYPE option<string>;

-- Price / currency (listing UI currency kept separate)
DEFINE FIELD IF NOT EXISTS listing_currency    ON TABLE guitars TYPE option<string>;

-- Condition / categories
DEFINE FIELD IF NOT EXISTS condition_slug      ON TABLE guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS condition_display   ON TABLE guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS categories          ON TABLE guitars TYPE option<array<string>>;
DEFINE FIELD IF NOT EXISTS categories[*]       ON TABLE guitars TYPE string;

-- Inventory / flags
DEFINE FIELD IF NOT EXISTS auction             ON TABLE guitars TYPE option<bool>;
DEFINE FIELD IF NOT EXISTS offers_enabled      ON TABLE guitars TYPE option<bool>;
DEFINE FIELD IF NOT EXISTS has_inventory       ON TABLE guitars TYPE option<bool>;
DEFINE FIELD IF NOT EXISTS inventory           ON TABLE guitars TYPE option<number>;

-- Timestamps from marketplace (do not replace core created_at/updated_at)
DEFINE FIELD IF NOT EXISTS created_at_market   ON TABLE guitars TYPE option<datetime>;
DEFINE FIELD IF NOT EXISTS published_at        ON TABLE guitars TYPE option<datetime>;

-- Shop info
DEFINE FIELD IF NOT EXISTS shop_id             ON TABLE guitars TYPE option<number>;
DEFINE FIELD IF NOT EXISTS shop_name           ON TABLE guitars TYPE option<string>;
DEFINE FIELD IF NOT EXISTS shop_slug           ON TABLE guitars TYPE option<string>;

-- Optional convenience mirror for finish display
DEFINE FIELD IF NOT EXISTS finish_display      ON TABLE guitars TYPE option<string>;


