# Agent Guide: Vacuum Hose Adapter OpenSCAD Repository

Welcome to the `vacuum-hose-adapter-openscad` repository. This repository provides a highly parametric OpenSCAD library for designing and 3D printing custom adapters, magnetic quick-connects, tool dust collection ports, osVAC connectors, and vacuum nozzles.

---

## 1. Repository Structure & Key Entry Points

```
vacuum-hose-adapter-openscad/
├── vacuum-hose-adapter.scad        ← Full Customizer entry file (all styles & parameters)
├── vacuum-hose-adapter-basic.scad  ← Basic Customizer entry file (hose-to-hose simplified)
├── funnels.scad                    ← Specialized funnel adapter entry point
├── funnels.json                    ← Funnel parameters & presets
├── modules/                        ← Core library modules & connector definitions
│   ├── vacuum-hose-adapter.scad    ← Primary library include file (HoseAdapter, UserConnectorSettings)
│   ├── constants.scad              ← Constants & indices for connector arrays
│   ├── modules_pipe.scad           ← Pipe & sweep geometry logic
│   └── connectors/                 ← Individual connector implementations
│       ├── connector_object.scad   ← UserConnectorSettings array builder & indices
│       ├── connector_hose.scad     ← Hose connector module
│       ├── connector_magnetic.scad ← Magnetic flange connector module
│       ├── connector_flange.scad   ← Mounting flange connector module
│       ├── connector_nozzle.scad   ← Nozzle shapes & tips module
│       ├── connector_osvac.scad    ← osVAC male & female connector modules
│       ├── connector_centec.scad   ← Cen-Tec male & female quick disconnects
│       ├── connector_makita.scad   ← Makita tool connector module
│       ├── connector_dyson.scad    ← Dyson tool connector module
│       ├── connector_camlock.scad  ← Camlock fitting module
│       └── connector_dw735.scad    ← DeWalt DW735 planer shroud connector module
├── demos/                          ← Demonstrations & example scad files
├── samples/                        ← PNG renders & reference images of sample outputs
└── scripts/                        ← Automation & render scripts (PowerShell test-render, thumbnail generation)
```

---

## 2. Library Inclusion & Integration

External OpenSCAD projects (e.g. projects in sibling workspace folders) include the main library file:

```scad
include <path/to/vacuum-hose-adapter-openscad/modules/vacuum-hose-adapter.scad>
```

Always use `include` (not `use`) so all functions, defaults, constants, and helper modules are available.

---

## 3. Core API: `HoseAdapter()` & `UserConnectorSettings()`

### 3.1 `HoseAdapter()` Signature

```scad
HoseAdapter(
  connector1 = UserConnectorSettings(...),
  connector2 = UserConnectorSettings(...),
  transitionStyle = "bend+taper", // "flat", "taper+bend", "bend+taper", "organicbend", "hull", "none"
  transitionLength = 0,            // Length of transition section (mm)
  transitionBendRadius = 0,        // Radius of bend if angled (mm)
  transitionAngle = 0,             // Angle of transition bend (degrees)
  transitionOffset = [0, 0],       // Center offset [x, y] in mm
  
  // Debug & Inspection
  sliceDebug = false,              // Render cross-section cutaway in preview
  showCaliper = false,             // Render caliper dimensions in preview
  end1Color = ["", 1],             // Color specification [color_name, alpha]
  end2Color = ["", 1],
  transitionColor = ["", 1]
);
```

---

### 3.2 `UserConnectorSettings()` Parameter Reference

#### General Parameters
| Parameter | Default | Description |
|---|---|---|
| `connector` | `1` | `1` for End 1, `2` for End 2. |
| `style` | `"hose"` | Connector type string (see Section 3.3). |
| `wallThickness` | `2` | Main wall thickness in mm. |
| `measurement` | `"outer"` | `"outer"` (OD measurement for insertion into hose) or `"inner"` (ID measurement for slipping over tool port). |
| `diameter` | `[100, 0]` | Vector `[mm, inch]` for connector diameter. |
| `length` | `[40, 0]` | Vector `[mm, inch]` for connector length. |
| `taper` | `0` | Taper amount in mm. Positive tapers outward toward end. |
| `rotation` | `0` | Z-axis rotation angle in degrees. |

#### Hose Connector Parameters (`style = "hose"`)
| Parameter | Description |
|---|---|
| `stopThickness` | Thickness of hose stop ring (mm). `0` disables stop. |
| `stopLength` | Length of hose stop ring (mm). |
| `stopSymmetrical` | `true`/`false` - taper both sides of stop. |
| `barbsCount` | Number of retention barbs. |
| `barbsThickness` | Barb height/thickness (mm). |
| `barbsSymmetrical` | `true`/`false` - taper both sides of barbs. |
| `endCapThickness` | End cap thickness (mm). `0` disables. |
| `endCapGridSize` | Mesh grid hole size for debris guard (mm). |
| `enableThreads` | `"disabled"`, `"enabled"` (left-hand), or `"reversed"` (right-hand). |
| `threadPitch` | Thread pitch in mm. |

#### Magnetic Flange Parameters (`style = "mag"`)
| Parameter | Description |
|---|---|
| `magnetCount` | Number of magnets (e.g. `8`). |
| `magnetDiameter` | Magnet pocket diameter (mm). Add 0.3–0.5mm clearance (e.g. `10.5` for 10mm magnet). |
| `magnetThickness` | Magnet depth (mm). Add 0.3–0.5mm clearance (e.g. `2.5` for 2mm magnet). |
| `magnetBorder` | Material around magnet pockets (mm). Default `2`. |
| `flangeThickness` | Total magnetic flange thickness (mm). Default `6`. |
| `alignmentRing` | `"no"`, `"recessed"`, or `"protruding"` seal ring interface. |

#### Screw Flange Parameters (`style = "flange"`)
| Parameter | Description |
|---|---|
| `flangeWidth` | Extra flange width added to connector diameter (mm). |
| `flangeThickness` | Mounting flange plate thickness (mm). |
| `screwCount` | Number of mounting holes (e.g. `4`). |
| `screwDiameter` | Screw hole diameter (mm). |

#### Nozzle Parameters (`style = "nozzle"`)
| Parameter | Description |
|---|---|
| `nozzleShape` | `"round"`, `"rectangle"`, or `"oval"`. |
| `nozzleSize` | `[width, depth, height]` vector for tip opening. |
| `nozzleRadius` | Corner rounding radius for nozzle opening (mm). |
| `nozzleChamferAngle` | Bevel angle at tip end (degrees). |

---

### 3.3 Connector Styles Summary

| `style` Identifier | Description |
|---|---|
| `"hose"` | Standard smooth, tapered, barbed, or threaded hose connector |
| `"mag"` | Quick-disconnect magnetic flange with magnet pockets |
| `"flange"` | Screw mounting flange for tool body attachment |
| `"osvacm"`, `"osvacm32"` | osVAC male quick-connect coupler |
| `"osvacf"`, `"osvacf32"` | osVAC female quick-connect coupler |
| `"centec_male"`, `"centec_female"` | Cen-Tec quick disconnect system |
| `"makita_male"` | Makita shop tool vacuum port connector |
| `"dyson"` | Dyson cordless tool latching attachment |
| `"camlock"` | Camlock quick disconnect fitting |
| `"dw735"` | DeWalt DW735 planer dust port adapter |
| `"kobalt"` | Kobalt saw dust outlet female socket with recessed ring channels |
| `"rigid_nxt"` | Rigid NXT shop vac hose connector with locking ridges |
| `"nozzle"` | Crevice tool, wide nozzle, or utility vacuum nozzle |
| `"none"` | Open or flat end |

---

## 4. Code Examples for Agents

### Example 1: 50mm Hose to 35mm Tool Port Adapter

```scad
include <modules/vacuum-hose-adapter.scad>

$fa = 3;
$fs = 0.1;

HoseAdapter(
  connector1 = UserConnectorSettings(
    connector = 1,
    style = "hose",
    wallThickness = 2.5,
    measurement = "outer",
    diameter = [50, 0],
    length = [35, 0],
    taper = 1,
    stopThickness = 1.5,
    stopLength = 3,
    stopSymmetrical = true
  ),
  connector2 = UserConnectorSettings(
    connector = 2,
    style = "hose",
    wallThickness = 2.5,
    measurement = "inner",
    diameter = [35, 0],
    length = [30, 0],
    taper = 0.5
  ),
  transitionStyle = "bend+taper",
  transitionLength = 15
);
```

### Example 2: Magnetic Flange Coupler

```scad
include <modules/vacuum-hose-adapter.scad>

$fa = 3;
$fs = 0.1;

HoseAdapter(
  connector1 = UserConnectorSettings(
    connector = 1,
    style = "mag",
    wallThickness = 2.5,
    measurement = "outer",
    diameter = [50, 0],
    length = [20, 0],
    magnetCount = 8,
    magnetDiameter = 10.5,
    magnetThickness = 2.5,
    magnetBorder = 3,
    flangeThickness = 6,
    alignmentRing = "recessed"
  ),
  connector2 = UserConnectorSettings(
    connector = 2,
    style = "hose",
    wallThickness = 2.5,
    measurement = "outer",
    diameter = [40, 0],
    length = [35, 0],
    taper = 1
  ),
  transitionStyle = "bend+taper",
  transitionLength = 15
);
```

---

## 5. Guide Pointers

- Detailed guide & recipes: [`docs/VACUUM_HOSE_ADAPTER_GUIDE.md`](file:///Users/ksteddom/Source/vacuum-hose-adapter-openscad/docs/VACUUM_HOSE_ADAPTER_GUIDE.md)
- Cursor agent rule: [`.cursor/rules/vacuum-hose-adapter-library.mdc`](file:///Users/ksteddom/Source/vacuum-hose-adapter-openscad/.cursor/rules/vacuum-hose-adapter-library.mdc)
