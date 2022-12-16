#include-once

Func BesselJ0($x)
	Return BesselJn($x, 0)
EndFunc

Func BesselJ1($x)
	Return BesselJn($x, 1)
EndFunc

Func BesselJn($x, $n)
	If ($n < 0) Then Return ((-1)^$n)*BesselJn($x, Abs($n))

	Local $aParams = [Int($n), $x]
	Local $intValue = IntegralQuadpackQNG(_BesselJnIntegral, 0, $Pi, 0, 1e-4, $aParams)

	Return (1/$Pi)*$intValue
EndFunc

Func _BesselJnIntegral($t, $aParams)
	Local $n = $aParams[0]
	Local $x = $aParams[1]

	Return Cos($n*$t - $x * Sin($t))
EndFunc