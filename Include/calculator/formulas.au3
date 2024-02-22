#include "..\translator.au3"
#include-once
; help table:
Global $aInfoFormulas = [ _
		"Absolute number|Gets the absolute value of an expression", _
		"Average|gets the total average of several set numbers", _
		"Body Mass Index|Gets the Body Mass Index based on a hight and a weigth", _
		"Radians to Degrees|Converts a given number of radians to degrees", _
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
		"Natural Logarithm|Calculates the natural logarithm of an expression", _
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
		"Random number|Between two numbers, (minimum and maximum value), gets a random number", _
		"Root|Applies any root of a number, eg: Fourth root of 1024", _
		"Square Root|Applies the square root of a given number", _
		"cube root|Applies the cube root of a given number", _
		"Time|Gets the time of a speed and distance", _
		"Speed|Gets the speed of a given distance and time", _
		"Percentage|Gets the percent of a minimum and maximum value" _
		]
; form table:
Global $aCommandTable = [ _
		["abs", 1], _
		["av", Null], _
		["bmi", 2], _
		["deg", 1], _
		["max", 2], _
		["min", 2], _
		["rad", 2], _
		["acc", 2], _
		["acos", 1], _
		["asin", 1], _
		["atan", 1], _
		["pc", 2], _
		["cos", 1], _
		["dox", 2], _
		["log", 1], _
		["nl", 2], _
		["ro", 1], _
		["sin", 1], _
		["tan", 1], _
		["ap-a1", 3], _
		["gp-a1", 3], _
		["ap-d", 3], _
		["gp-r", 3], _
		["ap-n", 3], _
		["gp-n", 3], _
		["ap-an", 3], _
		["gp-an", 3], _
		["ap-sn1", 3], _
		["gp-sn1", 3], _
		["raise", 2], _
		["rand", 2], _
		["root", 2], _
		["sr", 1], _
		["cr", 1], _
		["time", 2], _
		["vel", 2], _
		["per", 2 _
		]]
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
