#include-once

Func BooleAnd($p, $q)
	Return $p And $q
EndFunc

Func BooleOr($p, $q)
	Return $p Or $q
EndFunc

Func BooleNot($p)
	Return Not $p
EndFunc

Func BooleEqual($p, $q)
	Return $p = $q
EndFunc

Func BooleXor($p, $q)
	Return Not BooleEqual($p, $q)
EndFunc