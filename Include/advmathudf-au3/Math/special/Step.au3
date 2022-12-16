#include-once

Func Sign($x)
	If $x = 0 Then Return 0
	Return Abs($x)/$x
EndFunc

Func SawtoothWave($x, $a)
	Return 2*($t/$a - Floor(0.5-$t/$a))
EndFunc

Func SquareWave($x, $a)
	Return Sign(Sin($x*$a))
EndFunc

Func TrangleWave($x, $a)
	Return Abs(SawtoothWave($x, $a))*2-1
EndFunc