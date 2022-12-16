#include-once

Func Factor($x)
	Local $num = $x
	Local $arr[0]

	Do
		For $i = 2 To $num
			If Mod($num, $i) = 0 Then
				_ArrayAdd($arr, $i)
				$num /= $i
				ExitLoop
			EndIf
		Next
	Until $num = 1

	Return $arr
EndFunc

Func Divisors($x)
	Local $arr[1] = [1]

	For $i = 2 To ($x-1)
		If Mod($x, $i) = 0 Then _ArrayAdd($arr, $i)
	Next
	_ArrayAdd($arr, $x)

	Return $arr
EndFunc

Func GCD($a, $b)
	If $b = 0 Then Return $a
	Return GCD($b, Mod($a, $b))
EndFunc

Func LCM($a, $b)
	Return Abs($a*$b)/GCD($a, $b)
EndFunc

Func Factorial($n)
	Return Gamma($n+1)
EndFunc

Func FactorialN($x, $n)
	$m1 = $n^(($x-1)/$n)
	$m2 = Gamma($x/$n+1)/Gamma(1/$n+1)
	Return $m1*$m2
EndFunc

Func Superfactorial($n)
	$ret = 1
	For $i = 1 To $n
		$ret *= Gamma($i+1)
	Next
	Return $ret
EndFunc

Func Newton($n, $k)
	Return Factorial($n)/(Factorial($k)*Factorial($n-$k))
EndFunc

Func PowLastDigit($a, $b)
	Local $fA = Mod($a, 10)

	If $b = 0 Then Return 1

	Switch $fA
		Case 0
			Return 0
		Case 1
			Return 1
		Case 2
			Local $arr = [2, 4, 8, 6]

			Return $arr[Mod($b-1, 4)]
		Case 3
			Local $arr = [3, 9, 7, 1]

			Return $arr[Mod($b-1, 4)]
		Case 4
			Local $arr = [4, 6]

			Return $arr[Mod($b-1, 2)]
		Case 5
			Return 5
		Case 6
			Return 6
		Case 7
			Local $arr = [7, 9, 3, 1]

			Return $arr[Mod($b-1, 4)]
		Case 8
			Local $arr = [8, 4, 2, 6]

			Return $arr[Mod($b-1, 4)]
		Case 9
			Local $arr = [9, 1]

			Return $arr[Mod($b-1, 2)]
	EndSwitch

	Return 0
EndFunc

Func Lychrel($n)
	If StringReverse($n) = $n Then Return SetExtended(0, $n)
	Local $c = 0

	Do
		$c += 1
		$n = $n + StringReverse($n)
	Until StringReverse($n) = $n

	Return SetExtended($c, $n)
EndFunc
