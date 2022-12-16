#include-once

Func ArithmeticMean($a)
	Local $c = 0, $n = UBound($a)

	For $i = 0 To ($n-1)
		$c += $a[$i]
	Next

	Return $c/$n
EndFunc

Func HeinzMean($a, $b, $x)
	Return (($a^$x)*($b^(1-$x))+($a^(1-$x))*($b*$x))/2
EndFunc

Func LogMean($x, $y)
	If $x = 0 And $y = 0 Then Return 0
	If $x = $y Then Return $x
	Return ($y-$x)/(Log($y)-Log($x))
EndFunc

Func HeronianMean($x, $y)
	Return (1/3)*($x+Sqrt($x*$y)+$y)
EndFunc

Func StolarskyMean($x, $y, $p)
	If $x = $y Then Return $x
	Return (($x^$p-$y^$p)/($p*($x-$y)))^(1/($p-1))
EndFunc