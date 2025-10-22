-- Simple Banker guitars import (no conditionals)
-- Based on banker_guitars.json

-- Leslie
CREATE guitars:banker_leslie CONTENT {
  brand: "Banker",
  model: "Leslie",
  slug: "leslie",
  line: "Solidbody Electric",
  body_style: "Slab Single/Double Cut"
};

CREATE guitar_woods CONTENT {
  guitar_id: guitars:banker_leslie,
  body: "Honduran Mahogany or Korina",
  neck: "Quartersawn Honduran Mahogany or Korina",
  fingerboard: "Rosewood"
};

CREATE guitar_dimensions CONTENT {
  guitar_id: guitars:banker_leslie,
  scale_length: "24 3/4",
  nut_width: "1 11/16",
  neck_profile: "'59 \"D\" Shape",
  neck_thickness_1st: ".92",
  neck_thickness_12th: ".95",
  fingerboard_radius: "12",
  fret_count: 22,
  fret_type: "Jescar 45085 Nickel Silver"
};

CREATE guitar_hardware CONTENT {
  guitar_id: guitars:banker_leslie,
  bridge: "Faber Vintage Wraparound Bridge",
  tuning_machines: "Kluson Deluxe White Oval Button",
  nut: "Unbleached Polished Bone"
};

CREATE guitar_pickups CONTENT {
  guitar_id: guitars:banker_leslie,
  bridge: "Single Dogear P90",
  neck: "",
  middle: ""
};

CREATE guitar_controls CONTENT {
  guitar_id: guitars:banker_leslie,
  volume: "CTS 550k Potentiometer",
  tone: "CTS 550k Potentiometer",
  switch: "",
  other: ""
};

CREATE guitar_finish CONTENT {
  guitar_id: guitars:banker_leslie,
  body: "Nitrocellulose Lacquer",
  neck: "Nitrocellulose Lacquer",
  aging: "Optional Aging"
};

CREATE guitar_setup CONTENT {
  guitar_id: guitars:banker_leslie,
  strings: "Stringjoy 10-46 Pure Nickel",
  tuning: "Standard Tuning",
  action: "4/64"
};

-- Ironman CT Standard
CREATE guitars:banker_ironman_ct CONTENT {
  brand: "Banker",
  model: "Ironman CT Standard",
  slug: "ironman-ct-standard",
  line: "Solidbody Electric",
  body_style: "Bound Double Cutaway"
};

CREATE guitar_woods CONTENT {
  guitar_id: guitars:banker_ironman_ct,
  body: "Honduran Mahogany or Korina",
  neck: "Quartersawn Honduran Mahogany or Korina",
  fingerboard: "Rosewood"
};

CREATE guitar_dimensions CONTENT {
  guitar_id: guitars:banker_ironman_ct,
  scale_length: "24 3/4",
  nut_width: "1 5/8",
  neck_profile: "60 C Shape",
  neck_thickness_1st: ".91",
  neck_thickness_12th: ".93",
  fingerboard_radius: "12",
  fret_count: 22,
  fret_type: "Jescar 45085 Nickel Silver"
};

CREATE guitar_hardware CONTENT {
  guitar_id: guitars:banker_ironman_ct,
  bridge: "Faber Vintage Wraparound Bridge",
  tuning_machines: "Kluson Deluxe White Oval Button",
  nut: "Unbleached Polished Bone"
};

CREATE guitar_pickups CONTENT {
  guitar_id: guitars:banker_ironman_ct,
  bridge: "Single Dogear P90",
  neck: "",
  middle: ""
};

CREATE guitar_controls CONTENT {
  guitar_id: guitars:banker_ironman_ct,
  volume: "CTS 550k Potentiometer",
  tone: "CTS 550k Potentiometer",
  switch: "",
  other: ""
};

CREATE guitar_finish CONTENT {
  guitar_id: guitars:banker_ironman_ct,
  body: "Nitrocellulose Lacquer",
  neck: "Nitrocellulose Lacquer",
  aging: "Optional Aging"
};

CREATE guitar_setup CONTENT {
  guitar_id: guitars:banker_ironman_ct,
  strings: "Stringjoy 10-46 Pure Nickel",
  tuning: "Standard Tuning",
  action: "4/64"
};

-- Ironman CT Deluxe
CREATE guitars:banker_ironman_ct_deluxe CONTENT {
  brand: "Banker",
  model: "Ironman CT Deluxe",
  slug: "ironman-ct-deluxe",
  line: "Solidbody Electric",
  body_style: "Bound Double Cutaway"
};

CREATE guitar_woods CONTENT {
  guitar_id: guitars:banker_ironman_ct_deluxe,
  body: "Honduran Mahogany or Korina",
  neck: "Quartersawn Honduran Mahogany or Korina",
  fingerboard: "Rosewood"
};

CREATE guitar_dimensions CONTENT {
  guitar_id: guitars:banker_ironman_ct_deluxe,
  scale_length: "24 3/4",
  nut_width: "1 5/8",
  neck_profile: "60 C Shape",
  neck_thickness_1st: ".91",
  neck_thickness_12th: ".93",
  fingerboard_radius: "12",
  fret_count: 22,
  fret_type: "Jescar 45085 Nickel Silver"
};

CREATE guitar_hardware CONTENT {
  guitar_id: guitars:banker_ironman_ct_deluxe,
  bridge: "Faber Vintage Wraparound Bridge",
  tuning_machines: "Kluson Deluxe White Oval Button",
  nut: "Unbleached Polished Bone"
};

CREATE guitar_pickups CONTENT {
  guitar_id: guitars:banker_ironman_ct_deluxe,
  bridge: "Single Dogear P90",
  neck: "",
  middle: ""
};

CREATE guitar_controls CONTENT {
  guitar_id: guitars:banker_ironman_ct_deluxe,
  volume: "CTS 550k Potentiometer",
  tone: "CTS 550k Potentiometer",
  switch: "",
  other: ""
};

CREATE guitar_finish CONTENT {
  guitar_id: guitars:banker_ironman_ct_deluxe,
  body: "Nitrocellulose Lacquer",
  neck: "Nitrocellulose Lacquer",
  aging: "Optional Aging"
};

CREATE guitar_setup CONTENT {
  guitar_id: guitars:banker_ironman_ct_deluxe,
  strings: "Stringjoy 10-46 Pure Nickel",
  tuning: "Standard Tuning",
  action: "4/64"
};

-- Ironman CT Custom
CREATE guitars:banker_ironman_ct_custom CONTENT {
  brand: "Banker",
  model: "Ironman CT Custom",
  slug: "ironman-ct-custom",
  line: "Solidbody Electric",
  body_style: "Bound Double Cutaway"
};

CREATE guitar_woods CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom,
  body: "Honduran Mahogany or Korina",
  neck: "Quartersawn Honduran Mahogany or Korina",
  fingerboard: "Rosewood"
};

CREATE guitar_dimensions CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom,
  scale_length: "24 3/4",
  nut_width: "1 5/8",
  neck_profile: "60 C Shape",
  neck_thickness_1st: ".91",
  neck_thickness_12th: ".93",
  fingerboard_radius: "12",
  fret_count: 22,
  fret_type: "Jescar 45085 Nickel Silver"
};

CREATE guitar_hardware CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom,
  bridge: "Faber Vintage Wraparound Bridge",
  tuning_machines: "Kluson Deluxe White Oval Button",
  nut: "Unbleached Polished Bone"
};

CREATE guitar_pickups CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom,
  bridge: "Single Dogear P90",
  neck: "",
  middle: ""
};

CREATE guitar_controls CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom,
  volume: "CTS 550k Potentiometer",
  tone: "CTS 550k Potentiometer",
  switch: "",
  other: ""
};

CREATE guitar_finish CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom,
  body: "Nitrocellulose Lacquer",
  neck: "Nitrocellulose Lacquer",
  aging: "Optional Aging"
};

CREATE guitar_setup CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom,
  strings: "Stringjoy 10-46 Pure Nickel",
  tuning: "Standard Tuning",
  action: "4/64"
};

-- Ironman CT Custom Shop
CREATE guitars:banker_ironman_ct_custom_shop CONTENT {
  brand: "Banker",
  model: "Ironman CT Custom Shop",
  slug: "ironman-ct-custom-shop",
  line: "Solidbody Electric",
  body_style: "Bound Double Cutaway"
};

CREATE guitar_woods CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop,
  body: "Honduran Mahogany or Korina",
  neck: "Quartersawn Honduran Mahogany or Korina",
  fingerboard: "Rosewood"
};

CREATE guitar_dimensions CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop,
  scale_length: "24 3/4",
  nut_width: "1 5/8",
  neck_profile: "60 C Shape",
  neck_thickness_1st: ".91",
  neck_thickness_12th: ".93",
  fingerboard_radius: "12",
  fret_count: 22,
  fret_type: "Jescar 45085 Nickel Silver"
};

CREATE guitar_hardware CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop,
  bridge: "Faber Vintage Wraparound Bridge",
  tuning_machines: "Kluson Deluxe White Oval Button",
  nut: "Unbleached Polished Bone"
};

CREATE guitar_pickups CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop,
  bridge: "Single Dogear P90",
  neck: "",
  middle: ""
};

CREATE guitar_controls CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop,
  volume: "CTS 550k Potentiometer",
  tone: "CTS 550k Potentiometer",
  switch: "",
  other: ""
};

CREATE guitar_finish CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop,
  body: "Nitrocellulose Lacquer",
  neck: "Nitrocellulose Lacquer",
  aging: "Optional Aging"
};

CREATE guitar_setup CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop,
  strings: "Stringjoy 10-46 Pure Nickel",
  tuning: "Standard Tuning",
  action: "4/64"
};

-- Ironman CT Custom Shop Deluxe
CREATE guitars:banker_ironman_ct_custom_shop_deluxe CONTENT {
  brand: "Banker",
  model: "Ironman CT Custom Shop Deluxe",
  slug: "ironman-ct-custom-shop-deluxe",
  line: "Solidbody Electric",
  body_style: "Bound Double Cutaway"
};

CREATE guitar_woods CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe,
  body: "Honduran Mahogany or Korina",
  neck: "Quartersawn Honduran Mahogany or Korina",
  fingerboard: "Rosewood"
};

CREATE guitar_dimensions CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe,
  scale_length: "24 3/4",
  nut_width: "1 5/8",
  neck_profile: "60 C Shape",
  neck_thickness_1st: ".91",
  neck_thickness_12th: ".93",
  fingerboard_radius: "12",
  fret_count: 22,
  fret_type: "Jescar 45085 Nickel Silver"
};

CREATE guitar_hardware CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe,
  bridge: "Faber Vintage Wraparound Bridge",
  tuning_machines: "Kluson Deluxe White Oval Button",
  nut: "Unbleached Polished Bone"
};

CREATE guitar_pickups CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe,
  bridge: "Single Dogear P90",
  neck: "",
  middle: ""
};

CREATE guitar_controls CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe,
  volume: "CTS 550k Potentiometer",
  tone: "CTS 550k Potentiometer",
  switch: "",
  other: ""
};

CREATE guitar_finish CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe,
  body: "Nitrocellulose Lacquer",
  neck: "Nitrocellulose Lacquer",
  aging: "Optional Aging"
};

CREATE guitar_setup CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe,
  strings: "Stringjoy 10-46 Pure Nickel",
  tuning: "Standard Tuning",
  action: "4/64"
};

-- Ironman CT Custom Shop Deluxe with Case
CREATE guitars:banker_ironman_ct_custom_shop_deluxe_case CONTENT {
  brand: "Banker",
  model: "Ironman CT Custom Shop Deluxe with Case",
  slug: "ironman-ct-custom-shop-deluxe-case",
  line: "Solidbody Electric",
  body_style: "Bound Double Cutaway"
};

CREATE guitar_woods CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case,
  body: "Honduran Mahogany or Korina",
  neck: "Quartersawn Honduran Mahogany or Korina",
  fingerboard: "Rosewood"
};

CREATE guitar_dimensions CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case,
  scale_length: "24 3/4",
  nut_width: "1 5/8",
  neck_profile: "60 C Shape",
  neck_thickness_1st: ".91",
  neck_thickness_12th: ".93",
  fingerboard_radius: "12",
  fret_count: 22,
  fret_type: "Jescar 45085 Nickel Silver"
};

CREATE guitar_hardware CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case,
  bridge: "Faber Vintage Wraparound Bridge",
  tuning_machines: "Kluson Deluxe White Oval Button",
  nut: "Unbleached Polished Bone"
};

CREATE guitar_pickups CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case,
  bridge: "Single Dogear P90",
  neck: "",
  middle: ""
};

CREATE guitar_controls CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case,
  volume: "CTS 550k Potentiometer",
  tone: "CTS 550k Potentiometer",
  switch: "",
  other: ""
};

CREATE guitar_finish CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case,
  body: "Nitrocellulose Lacquer",
  neck: "Nitrocellulose Lacquer",
  aging: "Optional Aging"
};

CREATE guitar_setup CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case,
  strings: "Stringjoy 10-46 Pure Nickel",
  tuning: "Standard Tuning",
  action: "4/64"
};

CREATE guitar_case CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case,
  type: "Hard Case",
  included: true
};

-- Ironman CT Custom Shop Deluxe with Case and Gig Bag
CREATE guitars:banker_ironman_ct_custom_shop_deluxe_case_gig CONTENT {
  brand: "Banker",
  model: "Ironman CT Custom Shop Deluxe with Case and Gig Bag",
  slug: "ironman-ct-custom-shop-deluxe-case-gig",
  line: "Solidbody Electric",
  body_style: "Bound Double Cutaway"
};

CREATE guitar_woods CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig,
  body: "Honduran Mahogany or Korina",
  neck: "Quartersawn Honduran Mahogany or Korina",
  fingerboard: "Rosewood"
};

CREATE guitar_dimensions CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig,
  scale_length: "24 3/4",
  nut_width: "1 5/8",
  neck_profile: "60 C Shape",
  neck_thickness_1st: ".91",
  neck_thickness_12th: ".93",
  fingerboard_radius: "12",
  fret_count: 22,
  fret_type: "Jescar 45085 Nickel Silver"
};

CREATE guitar_hardware CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig,
  bridge: "Faber Vintage Wraparound Bridge",
  tuning_machines: "Kluson Deluxe White Oval Button",
  nut: "Unbleached Polished Bone"
};

CREATE guitar_pickups CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig,
  bridge: "Single Dogear P90",
  neck: "",
  middle: ""
};

CREATE guitar_controls CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig,
  volume: "CTS 550k Potentiometer",
  tone: "CTS 550k Potentiometer",
  switch: "",
  other: ""
};

CREATE guitar_finish CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig,
  body: "Nitrocellulose Lacquer",
  neck: "Nitrocellulose Lacquer",
  aging: "Optional Aging"
};

CREATE guitar_setup CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig,
  strings: "Stringjoy 10-46 Pure Nickel",
  tuning: "Standard Tuning",
  action: "4/64"
};

CREATE guitar_case CONTENT {
  guitar_id: guitars:banker_ironman_ct_custom_shop_deluxe_case_gig,
  type: "Hard Case and Gig Bag",
  included: true
};
