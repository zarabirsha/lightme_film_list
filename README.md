# lightme_film_list

Film stock and format database for the Lightme lightmeter app, shipped as a Swift package. The data lives in two JSON resources:

- `Sources/lightme_film_list/films.json` — one entry per film stock
- `Sources/lightme_film_list/formats.json` — one entry per film/sensor format

## Usage

```swift
import lightme_film_list

let filmsURL   = LightmeFilmList.json         // films.json, via Bundle.module
let formatsURL = LightmeFilmList.formatsJSON  // formats.json
```

## Legend — `films.json`

Every entry has exactly these fields:

| Field | Type | Meaning |
|---|---|---|
| `id` | `Int` | Unique, sequential; starts at `0`. `0` is reserved for the *"No film stock selected"* placeholder. |
| `longname` | `String` | Full display name, e.g. `HP5 Plus 400`. Usually omits the make. |
| `shortname` | `String` | Abbreviation shown in the lightmeter UI, max 8 characters, e.g. `HP5+`. |
| `factor` | `Double` | Reciprocity failure correction factor. Use `1` when no value is available in the datasheet. Values in use range from `1.0` to `1.54`. |
| `make` | `String` | Brand/manufacturer, free text. See the list of makes in use below for consistent naming. |
| `type` | `Int` | Emulsion kind, see table below. |
| `iso` | `Int` | Box speed. Verify against official product pages, never guess. |
| `whiteBalance` | `Int` | Color balance, see table below. |

### `type` values

| Value | Meaning | Examples |
|---|---|---|
| `0` | None (placeholder entry only) | *No film stock selected* |
| `1` | B&W negative | HP5 Plus 400, FOMAPAN 400 Action, EDU Ultra 400 |
| `2` | Color negative (C-41, or ECN-2 cine) | Portra 400, Vision3 500T, Amber T800 |
| `3` | Color slide / reversal (E-6) | Velvia 50, Ektachrome E100, KODACHROME 25 |
| `4` | B&W reversal / direct positive | FOMAPAN R 100, ADOX SCALA 160, Direct Positive Paper |
| `5` | Color instant | Polaroid 600, Instax Mini |
| `6` | B&W instant | Polaroid SX-70 B&W, Instax Wide Monochrome |

### `whiteBalance` values

| Value | Meaning |
|---|---|
| `1` | Daylight |
| `2` | Tungsten (typically T-suffixed cine stocks: CineStill 800T, Vision3 500T, Amber T800) |

### Makes currently in use

ADOX, Agfa, Arista, Bergger, CANDIDO, CatLABS, CineStill, dubblefilm, Ferrania, Film Washi, Flic Film, Foma, FPP, Fujifilm, Harman, Holga, Hundred film, Ilford, JCH, Kentmere, Kodak, KONO!, Leica, Lomography, Lucky, None, Optik Oldschool, Oriental, ORWO, Polaroid, Rera, RETO, Revolog, Rollei, Shanghai, Sreda Film Lab, Vibe, Yashica

## Legend — `formats.json`

Every entry has exactly these fields:

| Field | Type | Meaning |
|---|---|---|
| `id` | `Int` | Unique. `-1` is reserved for the `•` placeholder (no format selected). |
| `name` | `String` | Short display name, e.g. `6x6`, `4x5"`, `SUPER8`. |
| `sizemm` | `{ width, height }` | Frame size in millimeters. |
| `categoryIds` | `[Int]` | Categories the format belongs to, see table below. A format can belong to more than one (e.g. `FF` is both 35mm stills and a digital sensor size). |

### Category values (referenced by `categoryIds`)

| Value | Category | Formats |
|---|---|---|
| `-1` | None (placeholder) | `•` |
| `0` | 110 cartridge | `110` |
| `1` | 35mm stills | `FF`, `HF`, `24x24`, `XPAN` |
| `2` | 120 roll film | `6x3`, `6x6`, `6x7`, `6x8`, `6x9`, `6x12`, `6x17`, `6x24`, `645` |
| `3` | Sheet film (large format) | `2¼x3¼"`, `4x5"`, `4x10"`, `5x7"`, `8x10"`, `11x14"` |
| `4` | Motion picture | `STD8`, `SUPER8`, `16mm`, `STD35`, `SUPER35`, `Vista`, `Techniscope`, `IMAX` |
| `5` | Instant | `PolGO`, `Pol600`, `Mini`, `Square`, `Wide` |
| `6` | Digital sensor | `FF`, `APS-C`, `M4/3` |
| `7` | 127 roll film | `127` |

## Adding a new film stock

1. Append the entry at the end of `films.json` with the next sequential `id` (the list is kept sorted by `id`).
2. Set `factor: 1` unless the datasheet provides a reciprocity correction value.
3. Pick `type` and `whiteBalance` from the tables above; verify `iso` against an official product page — never guess. Skip limited editions with no confirmed speed.
4. Keep `shortname` at 8 characters or fewer, and reuse an existing `make` string when the brand is already present (e.g. `Harman` vs `Ilford`, `FPP` for Film Photography Project).
5. Validate the JSON and run `swift build && swift test` before committing.
