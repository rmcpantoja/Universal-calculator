#include-once

Func Anger($x, $v)
	Local $aParams = [$v, $x]
	Return (1/$Pi)*Integral(_AngerIntegral, 0, $Pi, 0.001, $aParams)
EndFunc

Func _AngerIntegral($x, $aParams)
	Cos($aParams[0]*$x - $aParams[1]*Sin($x))
EndFunc
