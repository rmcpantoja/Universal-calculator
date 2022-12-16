#include-once

Func Si($x)
	Return Integral(_SiIntegral, 0, $x, $__g_ADVMATHUDF_INTEGRALSTEP, 0, $M_INTEGRATE_SIMPSON)
EndFunc

Func Ci($x)
	Return Integral(_CiIntegral, 0, $x, $__g_ADVMATHUDF_INTEGRALSTEP, 0, $M_INTEGRATE_SIMPSON)+Log($x)+$EulerGamma
EndFunc

Func Shi($x)
	Return Integral(_ShiIntegral, 0, $x, $__g_ADVMATHUDF_INTEGRALSTEP, 0, $M_INTEGRATE_SIMPSON)
EndFunc

Func Chi($x)
	Return Integral(_ChiIntegral, 0, $x, $__g_ADVMATHUDF_INTEGRALSTEP, 0, $M_INTEGRATE_SIMPSON)+Log($x)+$EulerGamma
EndFunc

Func _SiIntegral($t)
	If $t = 0 Then Return 0
	Return Sin($t)/$t
EndFunc

Func _CiIntegral($t)
	If $t = 0 Then Return 0
	Return (Cos($t)-1)/$t
EndFunc

Func _ShiIntegral($t)
	If $t = 0 Then Return 0
	Return Sinh($t)/$t
EndFunc

Func _ChiIntegral($t)
	If $t = 0 Then Return 0
	Return (Cosh($t)-1)/$t
EndFunc
