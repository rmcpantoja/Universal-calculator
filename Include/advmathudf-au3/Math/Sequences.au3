#include-once

Func Fibonacci($n)
	Local $a = 1, $b = 1
	Local $i, $c

	For $i = 2 To $n
		$c = $a
		$a = $b
		$b = $b+$c
	Next

	Return $b
EndFunc

Func Lucas($n)
	Local $a = 1, $b = 3
	Local $i, $c

	If $n = 1 Then Return $a
	If $n = 2 Then Return $b

	For $i = 3 To $n
		$c = $a
		$a = $b
		$b = $b+$c
	Next

	Return $b
EndFunc

Func LucasLehmer($n)
	Local $a = 4
	Local $i

	For $i = 2 To $n
		$a = $a^2 - 2
	Next

	Return $a
EndFunc

Func Stirling1($n, $k)
	If $n = 0 And $k = 0 Then Return 1
	If $n = $k Then Return 1
	If $k = 0 Then Return 0
	If $k > $n Then Return 0

	Return ($n-1)*Stirling1($n-1, $k) + Stirling1($n-1, $k-1)
EndFunc

Func Stirling2($n, $k)
	If $n = $k Then Return 1
	If $k = 1 Then Return 1
	If $k > $n Then Return 0

	Return $k*Stirling2($n-1, $k) + Stirling2($n-1, $k-1)
EndFunc

Func Bell($n)
	If $n = 0 Or $n = 1 Then Return 1

	Local $sum = 0

	For $k = 0 To ($n-1)
		$sum += Newton($n-1, $k)*Bell($k)
	Next

	Return $sum
EndFunc

Func Bernoulli($m, $n)
	If $m = 0 Then Return 1
	Local $sum = 0

	For $k = 0 To $m-1
		$sum += Newton($m, $k)*Bernoulli($k, $n)/($m-$k+1)
	Next

	Return $n^$m - $sum
EndFunc

Func Catalan($n)
	Return Factorial(2*$n)/(Factorial($n)*Factorial($n+1))
EndFunc

Func Carol($n)
	Return (2^$n-1)^2-2
EndFunc

Func Cullen($n)
	Return $n*2^$n+1
EndFunc

Func _Pascal($iLevel = 2)
	Local $aRet[1] = [2]
	If $iLevel = 2 Then Return $aRet
	Local $i

	For $i = 3 To $iLevel
		$aRet = __Pascal($aRet)
	Next

	Return $aRet
EndFunc

Func __Pascal(ByRef $aRet)
	Local $ret[UBound($aRet)+1]
	Local $i

	For $i = 0 To UBound($aRet)
		$v1 = ($i > 0) ? $aRet[$i-1] : 1
		$v2 = ($i < UBound($aRet)) ? $aRet[$i] : 1
		$Ret[$i] = $v1+$v2
	Next

	Return $ret
EndFunc
