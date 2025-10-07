USE NS gear DB guitars;

CREATE guitar:banker_58_spec_v CONTENT {
  brand: "Banker",
  model: "58' Spec V",
  price_cents: 469900,
  price_currency: "USD",
  body_style: "V",
  woods: { body: "Korina", neck: "Quartersawn Korina", fretboard: "Rosewood" },
  dimensions: { scale_length: "24 3/4", radius: "12", nut_width: '1 11/16"' },
  pickups: [
    { position: "neck", type: "Humbucker", model: "PAF" },
    { position: "bridge", type: "Humbucker", model: "PAF" }
  ],
  hardware: { bridge: "Faber ABR-H", tailpiece: 'Solid Brass "V"', tuners: "Kluson Deluxe" },
  controls: [
    { name: "Volume", detail: "Neck" },
    { name: "Volume", detail: "Bridge" },
    { name: "Tone", detail: "Master" },
    { name: "Switch", detail: "Switchcraft 3-way" }
  ],
  finish: { type: "Nitrocellulose Lacquer", color: "Natural", aging: "Aged" },
  setup: { strings: "Stringjoy 10-46 Pure Nickel", tuning: "Standard", action: "4/64" }
};

CREATE guitar:gibson_1960_lp CONTENT {
  brand: "Gibson Murphy Lab",
  line: "Murphy Lab",
  model: "Wildwood Spec 1960 Les Paul Standard",
  variant: '"Beauty of the Burst" Page 151',
  price_cents: 0, price_currency: "USD",
  woods: { top: "2-Pc Figured Maple (HHG)", body: "1-Pc Lightweight Mahogany", neck: "Mahogany", fretboard: "Indian Rosewood (HHG)" },
  dimensions: { scale_length: "24.75", radius: "12", nut_width: '1.687"' },
  appointments: { inlays: "Aged Cellulose Nitrate Trapezoid", binding: "1-Ply Royalite" },
  pickups: [
    { position: "neck", type: "Humbucker", model: "Wildwood Spec Custombucker" },
    { position: "bridge", type: "Humbucker", model: "Wildwood Spec Custombucker" }
  ],
  hardware: { bridge: "No-Wire ABR-1", tailpiece: "Lightweight Aluminum Stopbar", tuners: "Kluson Double-Ring Single-Line", color: "Nickel" },
  controls: [
    { name: "Volume", detail: "Neck" },
    { name: "Volume", detail: "Bridge" },
    { name: "Tone", detail: "Neck" },
    { name: "Tone", detail: "Bridge" },
    { name: "Switch", detail: "3-way Toggle" }
  ],
  finish: { type: "Nitro", color: "Ice Tea Burst", aging: "Light Aged" },
  case_info: { type: "Brown/Pink Lifton Reissue 5-Latch", coa: true }
};
