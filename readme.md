# OpenSCAD project to create vacuum hose connectors.

Intended for generating connections that would allow connecting vacuum hoses and tools of different diameters together.

Parametrises settings support two connections types. Both connections types can be used on ether end of the connection.

## Hose connection
Intended for connection to a hose or a tool. 

Main setting:
* Diameter: Internal or external diameter of the intended connection.
* Length: The length of the connection end.
* Taper: the hose connection can be tapered to allow for a tighter fit.

## Magnetic flange connection
Intended for creating a quick removable connection. Allowing the hose to be quickly moved form device to device.

Main setting:
* Diameter: Internal diameter of the flange connection.
* Magnet count: Number of magnets to be added to the flange.
* Magnet diameter: Diameter of the magnets.
* Magnet thickness: Thickness of the magnets.

## Sample generated STL
![100mm hose to 50mm hose](/samples/100mmHoseTo50mmHose.jpg)

![100mm Magnetic flange](/samples/100mmMagnetic.jpg)

![100mm Magnetic 50mm hose](/samples/100mmMagneticTo50mmHose.jpg)