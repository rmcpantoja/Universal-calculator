#cs ----------------------------------------------------------------------------

	Example script for Advanced Math UDF
	INTEGRATION ALGORITHMS

#ce ----------------------------------------------------------------------------

#include "..\Math.au3"

; Integrate Sin(x) over [3, 5]
$fExact = Cos(3) - Cos(5)
$fTrapezoid = Integral(Sin, 3, 5, 0.001, 0, $M_INTEGRATE_TRAPEZOID)
$fSimpson = Integral(Sin, 3, 5, 0.001, 0, $M_INTEGRATE_SIMPSON)
ConsoleWrite("Sin(x) over [3, 5]:"&@CRLF)
ConsoleWrite("Trapezoid: "&$fTrapezoid&", error: "&Abs($fTrapezoid-$fExact)&@CRLF)
ConsoleWrite("Simpson: "&$fSimpson&", error: "&Abs($fSimpson-$fExact)&@CRLF)
ConsoleWrite("Exact: "&$fExact&@CRLF&@CRLF)

; Integrate AiryAi(x) over [3, 7]
$fExact = 0.00341268434990151
$fTrapezoid = Integral(AiryAi, 3, 7, 0.001, 0, $M_INTEGRATE_TRAPEZOID)
$fSimpson = Integral(AiryAi, 3, 7, 0.001, 0, $M_INTEGRATE_SIMPSON)
ConsoleWrite("Ai(x) over [0, 1]:"&@CRLF)
ConsoleWrite("Trapezoid: "&$fTrapezoid&", error: "&Abs($fTrapezoid-$fExact)&@CRLF)
ConsoleWrite("Simpson: "&$fSimpson&", error: "&Abs($fSimpson-$fExact)&@CRLF)
ConsoleWrite("Exact: "&$fExact&@CRLF&@CRLF)