#include-once

Func FresnelS($x)
	Return Integral(_FresnelSIntegral, 0, $x)
EndFunc

Func FresnelC($x)
	Return Integral(_FresnelCIntegral, 0, $x)
EndFunc

Func _FresnelSIntegral($x)
	Return Sin($x^2)
EndFunc

Func _FresnelCIntegral($x)
	Return Cos($x^2)
EndFunc