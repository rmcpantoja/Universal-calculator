#include-once

Func BellCurve($x, $a, $b, $c)
	Return $a*Exp(-(($x-$b)^2)/(2*$c^2))
EndFunc

Func ParabolaCurve($x, $p)
	Return Sqrt(4*$p*$x)
EndFunc

Func CubicCurve($x)
	Return $x^3
EndFunc

Func QuarticCurve($x)
	Return $x^4
EndFunc

Func FoliumCurve($p, $a)
	Local $arr[2]

	$arr[0] = (3*$a*$p)/(1+$p^3)
	$arr[1] = (3*$a*$p^2)/(1+$p^3)

	Return $arr
EndFunc

Func CissoidCurve($a, $theta)
	Local $arr[2]

	$t = Tan($theta)
	$arr[0] = 2*$a * Sin($theta)^2
	$arr[1] = (2*$a*$t^3)/(1+$t^2)

	Return $arr
EndFunc

Func ConchoidCurve($a, $theta)
	Local $arr[2]

	$r = sec($theta)+$a*Cos($theta)
	$ret[0] = Cos($theta)*$r
	$ret[1] = Sin($theta)*$r

	Return $arr
EndFunc

Func SemicubicalParabolaCurve($a, $t)
	Local $arr[2]

	$ret[0] = $t^2
	$ret[1] = $a*$t^3

	Return $arr
EndFunc

Func SerpentineCurve($a, $b, $x)
	Return ($a*$b*$x)/($x^2+$a^2)
EndFunc