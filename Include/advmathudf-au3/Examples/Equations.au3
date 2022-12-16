#cs ----------------------------------------------------------------------------

	Example script for Advanced Math UDF
	EQUATIONS

	Results from Wolfram|Alpha:
	Sin(x) = 0 for x = n*Pi, where n is an integer
	x^2 - x - 2 = 0 for x = -1 or 2

#ce ----------------------------------------------------------------------------

#include "..\Math.au3"

$fRoot = Solve(F, 2)
ConsoleWrite("Sin(x) = 0 for x = "&$fRoot&@CRLF)

$fRoot = Solve(F2, 2)
ConsoleWrite("x^2 - x - 2 = 0 for x = "&$fRoot&@CRLF)

$fRoot = SolveDiff(F, 2)
ConsoleWrite("Sin'(x) = 0 for x = "&$fRoot&@CRLF)

$fRoot = SolveDiff(F2, 2)
ConsoleWrite("(x^2 - x - 2)'(x) = 0 for x = "&$fRoot&@CRLF)

Func F($x)
	Return Sin($x)
EndFunc

Func F2($x)
	Return $x^2 - $x - 2
EndFunc
