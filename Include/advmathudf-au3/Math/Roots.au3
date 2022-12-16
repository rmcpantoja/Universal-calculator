#include-once

Func NRoot($x, $b)
	Return $x^(1/$b)
EndFunc

Func Cbrt($x)
	Return NRoot($x, 3)
EndFunc