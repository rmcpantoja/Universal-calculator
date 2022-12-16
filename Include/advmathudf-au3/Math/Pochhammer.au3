#include-once

Func RisingFactrorial($x, $n)
	Return Factorial($n)*Newton($x+$n-1, $n)
EndFunc

Func FallingFactrorial($x, $n)
	Return Factorial($n)*Newton($x, $n)
EndFunc