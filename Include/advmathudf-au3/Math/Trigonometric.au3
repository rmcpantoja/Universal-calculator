#include-once

Func Cot($x)
	Return 1/Tan($x)
EndFunc

Func Sec($x)
	Return 1/Cos($x)
EndFunc

Func Csc($x)
	Return 1/Sin($x)
EndFunc

Func ACot($x)
	Return ACos(-1)/2 - ATan($x)
EndFunc

Func ASec($x)
	Return ACos(1/$x)
EndFunc

Func ACsc($x)
	Return ASin(1/$x)
EndFunc

Func ATan2($y, $x)
	If $x > 0 Then
		Return ATan($y/$x)
	ElseIf $x < 0 And $y >= 0 Then
		Return ATan($y/$x) + ACos(-1)
	ElseIf $x < 0 And $y < 0 Then
		Return ATan($y/$x) - ACos(-1)
	ElseIf $x = 0 And $y > 0 Then
		Return ACos(-1)/2
	ElseIf $x = 0 And $y < 0 Then
		Return -ACos(-1)/2
	Else
		Return 0
	EndIf
EndFunc