#include-once

Func Erf($x)
	Local $a = (8*($Pi-3))/(3*$Pi*(4-$Pi))

	Return Sign($x)*Sqrt(1-Exp(-($x^2)*(4/$Pi + $a*$x^2)/(1+$a*$x^2)))
EndFunc

Func Erfc($x)
	Return 1 - Erf($x)
EndFunc