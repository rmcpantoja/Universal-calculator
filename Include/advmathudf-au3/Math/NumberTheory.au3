#include-once

Func Pi($x)
	Local $n = 0
	For $i = 1 To $x
		If IsPrime($i) Then $n += 1
	Next

	Return $n
EndFunc

Func Tau($x)
	Return Sigma($x, 0)
EndFunc

Func Sigma($x, $n = 1)
	Local $ret = 0
	$arr = Divisors($x)
	For $i = 0 To (UBound($arr)-1)
		$ret += $arr[$i]^$n
	Next
	Return $ret
EndFunc

Func EulerTotient($x)
	If IsPrime($x) Then Return $x-1
	Local $n = 0
	For $i = 1 To ($x-1)
		If IsCoprime($x, $i) Then $n += 1
	Next
	Return $n
EndFunc