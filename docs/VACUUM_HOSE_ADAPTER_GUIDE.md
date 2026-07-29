# Agent & Developer Guide: Vacuum Hose Adapter OpenSCAD Library

This guide provides technical documentation for AI agents and human developers for utilizing, embedding, or extending the `vacuum-hose-adapter-openscad` library.

---

## 1. Including the Library

In your OpenSCAD scripts, include the primary library module:

```scad
include <modules/vacuum-hose-adapter.scad>
```

If including from an external repository (e.g. `openSCAD/my_project/my_project.scad`), use relative pathing:

```scad
include <../../vacuum-hose-adapter-openscad/modules/vacuum-hose-adapter.scad>
```

---

## 2. Core API Architecture

The entry function for constructing dual-connector adapters is `HoseAdapter()`. It consumes two connector object structures constructed via `UserConnectorSettings()`.

```scad
HoseAdapter(
  connector1 = UserConnectorSettings(...),
  connector2 = UserConnectorSettings(...),
  transitionStyle = "bend+taper", // "flat", "taper+bend", "bend+taper", "organicbend", "hull", "none"
  transitionLength = 0,            // Length of transition section in mm
  transitionBendRadius = 0,        // Bend radius in mm
  transitionAngle = 0,             // Angle of transition bend in degrees
  transitionOffset = [0, 0],       // [X, Y] offset in mm
  
  sliceDebug = false,              // Cutaway view for debugging interior
  showCaliper = false,             // Render dimension calipers
  end1Color = ["", 1],
  end2Color = ["", 1],
  transitionColor = ["", 1]
);
```

---

## 3. Parameter Dictionary (`UserConnectorSettings`)

### Common Options
- `connector`: `1` or `2`.
- `style`: Connector type (see Section 4).
- `wallThickness`: Main wall thickness in mm (default `2`).
- `measurement`: `"outer"` (OD for inserting into hose/port) or `"inner"` (ID for fitting over pipe).
- `diameter`: `[mm, inch]` tuple, e.g., `[50, 0]`.
- `length`: `[mm, inch]` tuple, e.g., `[40, 0]`.
- `taper`: Taper angle in mm. Positive tapers outward toward end.
- `rotation`: Rotation angle around Z-axis in degrees.

### Hose Connector Options (`style = "hose"`)
- `stopThickness`: Thickness of hose stop ring (mm). `0` disables stop.
- `stopLength`: Length of hose stop ring (mm).
- `stopSymmetrical`: `true`/`false` - taper both sides of stop.
- `barbsCount`: Number of retention barbs.
- `barbsThickness`: Height/thickness of barbs (mm).
- `barbsSymmetrical`: `true`/`false`.
- `endCapThickness`: Debris cap thickness (mm). `0` disables cap.
- `endCapGridSize`: Grid hole size for debris cap (mm).
- `enableThreads`: `"disabled"`, `"enabled"` (left-hand thread), or `"reversed"` (right-hand thread).
- `threadPitch`: Pitch in mm.

### Magnetic Flange Options (`style = "mag"`)
- `magnetCount`: Number of magnet pockets.
- `magnetDiameter`: Hole diameter in mm (add 0.3–0.5mm clearance, e.g., `10.5` for 10mm magnet).
- `magnetThickness`: Pocket depth in mm (add 0.3–0.5mm clearance, e.g., `2.5` for 2mm magnet).
- `magnetBorder`: Extra wall material around magnet pockets (mm).
- `flangeThickness`: Total flange face thickness (mm).
- `alignmentRing`: `"no"`, `"recessed"`, or `"protruding"`.

### Screw Flange Options (`style = "flange"`)
- `flangeWidth`: Added flange width relative to connector diameter (mm).
- `flangeThickness`: Flange plate thickness (mm).
- `screwCount`: Number of screw holes.
- `screwDiameter`: Hole diameter in mm (e.g. `4.5` for M4).

### Nozzle Options (`style = "nozzle"`)
- `nozzleShape`: `"round"`, `"rectangle"`, or `"oval"`.
- `nozzleSize`: `[width, depth, height]` vector for tip opening.
- `nozzleRadius`: Corner rounding radius (mm).
- `nozzleChamferAngle`: Bevel angle at tip end (degrees).

---

## 4. Supported Connector Styles

| Style Code | Description |
|---|---|
| `"hose"` | Standard smooth, tapered, barbed, or threaded hose connector |
| `"mag"` | Quick-disconnect magnetic flange with magnet pockets |
| `"flange"` | Mounting flange with screw holes for tool bodies |
| `"osvacm"`, `"osvacm32"` | osVAC male quick-connect coupler |
| `"osvacf"`, `"osvacf32"` | osVAC female quick-connect coupler |
| `"centec_male"`, `"centec_female"` | Cen-Tec quick disconnect system |
| `"makita_male"` | Makita tool vacuum port connector |
| `"dyson"` | Dyson cordless tool latching attachment |
| `"camlock"` | Camlock quick disconnect fitting |
| `"dw735"` | DeWalt DW735 planer dust port adapter |
| `"kobalt"` | Kobalt saw dust outlet female socket with recessed ring channels |
| `"nozzle"` | Crevice tool, wide nozzle, or utility vacuum nozzle |
| `"none"` | Open or flat end |

---

## 5. Standard Code Recipes

### Recipe 1: 50mm to 35mm Hose Adapter
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

### Recipe 2: Magnetic Flange to Hose
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
