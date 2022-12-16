#include-once

Func LinearInterpolation($x, $a, $b)
	Return $a*(1-$x)+$b*$x
EndFunc

Func CosineInterpolation($x, $a, $b)
	Local $ft = $x*$Pi
	Local $f = (1-Cos($ft))/2

	Return $a*(1-$f)+$b*$f
EndFunc

Func CubicInterpolation($x, $a, $b, $c, $d)
	Local $p = ($d-$c)-($b-$a)
	Local $q = ($a-$b)-$p
	Local $r = $c-$a
	Local $s = $b

	Return $p*$x^3 + $q*$x^2+$r*$x+$s
EndFunc