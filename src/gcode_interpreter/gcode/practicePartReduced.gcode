;FLAVOR:Marlin
;TIME:39
;Filament used: 0.0500785m
;Layer height: 0.2
;MINX:90.2
;MINY:90.2
;MINZ:0.3
;MAXX:109.8
;MAXY:109.8
;MAXZ:0.3
;TARGET_MACHINE.NAME:Prusa i3
;Generated with Cura_SteamEngine 5.9.0
;M140 S60 ;set bed temperature
;M105
;M190 S60
M104 S200
M105
M109 S200
M82 ;absolute extrusion mode
G21 ;metric values
G90 ;absolute positioning
M82 ;set extruder to absolute mode
M107 ;start with the fan off
G1 X0 Y0 ;move X/Y to min endstops
G1 Z0 ;move Z to min endstops
G1 Z15.0 F9000 ;move the platform down 15mm
G92 E0 ;zero the extruded length
G1 F200 E20 ;extrude 3mm of feed stock
G92 E0 ;zero the extruded length again
G1 F9000
;Put printing message on LCD screen
M117 Printing...
G92 E0
G92 E0
G1 F1500 E-6.5
;LAYER_COUNT:1
;LAYER:0
M107
;MESH:PracticePart.STL
G0 F3600 X109.4 Y109.4 Z0.3
;TYPE:WALL-INNER
G1 F1500 E0
G1 F1800 X109.4 Y90.6 E0.93794
G1 X90.6 Y90.6 E1.87587
G1 X90.6 Y109.4 E2.81381
G1 X109.4 Y109.4 E3.75174
G0 F3600 X109.8 Y109.8
G1 F1500 E-2.74826
M140 S0
M104 S0 ;extruder heater off
M140 S0 ;heated bed heater off (if you have it)
;G91 ;relative positioning
G1 E-3.74826 F300  ;retract the filament a bit before lifting the nozzle, to release some of the pressure
G1 Z0.8 E-8.74826 X89.8 Y89.8 F9000 ;move Z up a bit and retract filament even more
G1 X0 Y0 ;move X/Y to min endstops, so the head is out of the way
M84 ;steppers off
G90 ;absolute positioning
M82 ;absolute extrusion mode
M104 S0
;End of Gcode