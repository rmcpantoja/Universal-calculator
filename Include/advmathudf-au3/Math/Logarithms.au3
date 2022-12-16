#include-once

Func LogN($x, $b)
	Return Log($x)/Log($b)
EndFunc

Func Log10($x)
	Return LogN($x, 10)
EndFunc

Func Log2($x)
	Return LogN($x, 2)
EndFunc

Func Logit($x)
	Return Log($x/(1-$x))
EndFunc