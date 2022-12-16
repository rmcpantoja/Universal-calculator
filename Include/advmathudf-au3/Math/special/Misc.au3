#include-once

Func Clausen($theta)
	Return -Integral(_ClausenInt, 0, $theta)
EndFunc

Func _ClausenInt($x)
	Return Log(2*Sin($x/2))
EndFunc