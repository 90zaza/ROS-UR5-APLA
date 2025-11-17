M104 S200 ; Set nozzle temperature
M105 ; Ask for nozzle temperature
M109 S200 ; Wait till nozzle temperature has been reached
M83  ; Use relative extrusion mode
G21  ; Metric values
G90  ; Absolute positioning
;M302 P1  ; Allow cold extrusion
;M564 S0 H0  ; Allow movement outside limits
;M207 S0  ; Disable firmware retraction

G28  ; Home all axes
G90  ; Ensure absolute positioning
G1 X0 Y0 Z15 F1800  ; Move up before extruding

;G1 X0.1 Y0.1 F600  ; Tiny move to wake up Duet
G1 F200 E20  ; Extrude 20mm of filament
G1 F200 E-2

;M18 E0

;G0 F600 X109.4 Y109.4 Z0.3
G1 F1200 X249.389 Y249.389 Z0.3

G1 F200 E2
;G92 E0  ; Ensure extruder reset
;M17 E0

;T0  ; Ensure tool is active
;M83  ; Relative extrusion mode

;G1 F600 X109.4 Y90.6 E0.93794
;G1 X90.6 Y90.6 E0.93794
;G1 X90.6 Y109.4 E0.93794
;G1 X109.4 Y109.4 E0.93794
;G92 E0
G1 X50.611 Y249.389 E9.83443
G1 X50.611 Y50.611 E9.83443
G1 X249.389 Y50.611 E9.83443
G1 X249.389 Y249.329 E9.83443

;G0 F1200 X109.8 Y109.8 Z20
G1 X248.994 Y249.389 Z20

G1 E-5 F200  ; Retract filament by 5mm

M107
M104 S0  ; Extruder heater off
;End of Gcode
