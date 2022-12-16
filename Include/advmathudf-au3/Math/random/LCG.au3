#include-once

;$fStartValue, $fMultiplier, $fIncrement, $fModulus
Func LCG(ByRef $aPRNGParams)
	Return LCGValue
EndFunc

Func LCGValue(ByRef $aPRNGParams)
	Local $x = $aPRNGParams[0]
	$aPRNGParams[0] = Mod($aPRNGParams[0]*$aPRNGParams[1] + $aPRNGParams[2], $aPRNGParams[3])
	Return $x
EndFunc