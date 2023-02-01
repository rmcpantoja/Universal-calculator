#include "..\translator.au3"
#include-once
; help table:
global $aInfoFormulas = ["Radians to Degrees|Converts a given number of radians to degrees", _
		"Maximum number|Between two numbers, check which is the maximum", _
		"Minimum number|Between two numbers, check which is the minimum", _
		"Degrees to Radians|Converts a given number of degrees to radians", _
		"Acceleration|Gets the acceleration from a speed and time", _
		"arccosine|Calculates the arccosine of an expression", _
		"Arcsine|Calculates the arcsine of an expression", _
		"Arctangent|Calculates the arctangent of an expression", _
		"Perimeter Calculation|Calculates the perimeter based on the length and width of either a rectangle or any shape you want", _
		"Cosine|Calculates the cosine of an expression", _
		"distance|Gets the distance of a given speed or time", _
		"Logarithm|Calculates the logarithm of an expression", _
		"round|Rounds a decimal number to the nearest possible", _
		"Sine|Calculates the sine of an expression", _
		"tangent|Calculates the tangent of an expression", _
		"Arithmetic progression: a1|Gets the first term", _
		"Geometric progression: a1|Gets the first term of a geometric progression", _
		"Arithmetic progression: d|Get the difference", _
		"Geometric progression: R|Gets the reason", _
		"Arithmetic progression: n|Gets the term number", _
		"Geometric progression: N|Gets the term number", _
		"Arithmetic progression: AN|Get the nth term", _
		"Geometric progression: an|Get the nth term", _
		"Arithmetic progression: SN1|This is the first method that adds the terms", _
		"Geometric progression: sn1|First method that adds the terms", _
		"Raise|Power, eg: 3 to the power of 8", _
		"Root|Applies any root of a number, eg: Fourth root of 1024", _
		"Square Root|Applies the square root of a given number", _
		"cube root|Applies the cube root of a given number", _
		"Time|Gets the time of a speed and distance", _
		"Speed|Gets the speed of a given distance and time"]
; form table:
global $aCommandTable = [["deg", 1], ["max", 2], ["min", 2], ["rad", 2], ["acc", 2], ["acos", 1], ["asin", 1], ["atan", 1], ["pc", 2], ["cos", 1], ["dox", 2], ["log", 1], ["ro", 1], ["sin", 1], ["tan", 1], ["ap-a1", 3], ["gp-a1", 3], ["ap-d", 3], ["gp-r", 3], ["ap-n", 3], ["gp-n", 3], ["ap-an", 3], ["gp-an", 3], ["ap-sn1", 3], ["gp-sn1", 3], ["raise", 2], ["root", 2], ["sr", 1], ["cr", 1], ["time", 2], ["vel", 2]]
; #FUNCTION# ====================================================================================================================
; Name ..........: _get_formule_table
; Description ...: Gets the default formula table, useful for working with parameters.
; Syntax ........: _get_formule_table()
; Parameters ....: None
; Return values .: Default formula table
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _get_formule_table()
	Return $aCommandTable
EndFunc   ;==>_get_formule_table
