#include-once

;$sAlgName, $iState ...
Func Xorshift(ByRef $aPRNGParams)
	Switch $aPRNGParams[0]
		Case "Xorshift32"
			Return Xorshift32Value
		Case "Xorshift128"
			Return Xorshift128Value
	EndSwitch
EndFunc

Func Xorshift32Value(ByRef $aPRNGParams)
	Local $x = $aPRNGParams[1]
	$x = BitXOR($x, BitShift($x, -13))
	$x = BitXOR($x, BitShift($x, 17))
	$x = BitXOR($x, BitShift($x, -5))
	$aPRNGParams[1] = $x
	Return $x
EndFunc

Func Xorshift128Value(ByRef $aPRNGParams)
	Local $x = $aPRNGParams[4]
	$x = BitXOR($x, BitShift($x, -11))
	$x = BitXOR($x, BitShift($x, 8))
	$aPRNGParams[4] = $aPRNGParams[3]
	$aPRNGParams[3] = $aPRNGParams[2]
	$aPRNGParams[2] = $aPRNGParams[1]
	$x = BitXOR($x, $aPRNGParams[1])
	$x = BitXOR($x, BitShift($aPRNGParams[1], 19))
	$aPRNGParams[1] = $x
	Return $x
EndFunc