#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _PerimeterCalculation
; Description ...:
; Syntax ........: _PerimeterCalculation($length, $width)
; Parameters ....: $length              - an unknown value.
;                  $width               - an unknown value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _PerimeterCalculation($length, $width)
	$perimeter = 2 * ($length + $width)
	Return $perimeter
EndFunc
