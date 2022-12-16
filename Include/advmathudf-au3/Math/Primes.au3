#include-once

Func IsCoprime($a, $b)
	If GCD($a, $b) = 1 Then Return True
	Return False
EndFunc

Func IsPrime($n, $iTest = $M_PRIME_NAIVE1)
	Switch $iTest
		Case $M_PRIME_NAIVE1
			Return IsPrime1($n)
		Case $M_PRIME_NAIVE2
			Return IsPrime2($n)
		Case $M_PRIME_NAIVE3
			Return IsPrime3($n)
		Case $M_PRIME_AKS
			Return IsPrimeAKS($n)
		Case $M_PRIME_LUCAS
			Return IsPrimeLucas($n)
	EndSwitch
EndFunc

Func IsPrime1($a)
	Local $i
	If $a < 2 Then Return False
	For $i = 2 To ($a-1)
		If Mod($a, $i) = 0 Then Return False
	Next
	Return True
EndFunc

Func IsPrime2($a)
	Local $i
	If $a < 2 Then Return False
	For $i = 2 To Sqrt($a)
		If Mod($a, $i) = 0 Then Return False
	Next
	Return True
EndFunc

Func IsPrime3($a)
	Local $i
	If $a < 2 Then Return False
	If $a = 2 Then Return True
	For $i = 3 To Sqrt($a) Step +2
		If Mod($a, $i) = 0 Then Return False
	Next
	Return True
EndFunc

Func IsPrimeAKS($n)
	Local $aCoeffs = _Pascal($n)
	Local $i

	For $i = 0 To UBound($aCoeffs)-1
		If Mod($aCoeffs[$i], $n) <> 0 Then Return False
	Next

	Return True
EndFunc

Func IsPrimeLucas($a)
	Return Mod(Lucas($a)-1, $a) = 0
EndFunc

Func IsMersennePrime($p)
	Local $m = 2^$p - 1
	Return Mod(LucasLehmer($p-1), $m) = 0
EndFunc

Func ListPrimes($n)
	Local $arr[0], $c = 0, $i = 2

	If $n = 0 Then Return $arr

	Do
		If IsPrime3($i) Then
			_ArrayAdd($arr, $i)
			$c += 1
		EndIf
		$i += 1
	Until $c = $n

	Return $arr
EndFunc

Func ListPrimes2($lt)
	Local $arr[0]

	For $i = 2 To $lt
		If IsPrime3($i) Then _ArrayAdd($arr, $i)
	Next

	Return $arr
EndFunc

Func ListPrimes3($k, $k0 = 1, $arr = 0)
	If Not IsArray($arr) Then $arr = __Array1D(0)
	Local $i = 2

	For $i = $k0 To $k
		If IsPrime3(6*$i-1) Then _ArrayAdd($arr, 6*$i-1)
		If IsPrime3(6*$i+1) Then _ArrayAdd($arr, 6*$i+1)
	Next

	Return $arr
EndFunc

Func NthPrime($n)
	Local $c = 0, $p, $i = 1

	Do
		If IsPrime3($i) Then
			$c += 1
			$p = $i
		EndIf
		$i += 1
	Until $c = $n

	Return $p
EndFunc

Func __Array1D($l)
	Local $a[$l]
	Return $a
EndFunc