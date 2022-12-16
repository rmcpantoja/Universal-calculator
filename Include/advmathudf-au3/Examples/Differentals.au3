#cs ----------------------------------------------------------------------------

	Example script for Advanced Math UDF
	DIFFERENTIALS

	Results from Wolfram|Alpha:
	Sin'(0.5) = 0.877583
	MyFunc'(2) = 2 * cos(6) * sec(2)^2 - 2 * sin(6) * tan(2) ~ 9.86775

#ce ----------------------------------------------------------------------------

#include "..\Math.au3"

; 1. Differentiate the Sin($x) function for $x = 0.5
Global $vResult1 = Differential(Sin, 0.5)
ConsoleWrite("Sin'(0.5) = " & $vResult1 & @CRLF)

; 2. Differentiate the Sin($x) function for $x = 0.5 with increased precision (lower delta)
Global $vResult2 = Differential(Sin, 0.5, 0.00000001)
ConsoleWrite("Sin'(0.5) = " & $vResult2 & @CRLF)

; 3. Differentiate user-defined funtion for $x = 2
Global $vResult3 = Differential(MyFunc, 2)
ConsoleWrite("MyFunc'(2) = " & $vResult3 & @CRLF)

; 4. Differentiate user-defined funtion for $x = 2 with increased precision (lower delta)
Global $vResult4 = Differential(MyFunc, 2, 0.00000001)
ConsoleWrite("MyFunc'(2) = " & $vResult4 & @CRLF)

Func MyFunc($x)
	Return Tan($x) * Cos($x + 4) * 2
EndFunc