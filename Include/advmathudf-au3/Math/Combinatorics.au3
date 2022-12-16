#include-once

Func Combination($iN, $iK)
	If $iK > $iN Then Return 0
	Return Factorial($iN)/(Factorial($iK)*Factorial($iN-$iK))
EndFunc

Func CombinationR($iN, $iK)
	If $iK > $iN Then Return 0
	Return Combination($iN+$iK-1, $iK)
EndFunc

Func Variation($iN, $iK)
	If $iK > $iN Then Return 0
	Return Factorial($iN)/Factorial($iN-$iK)
EndFunc

Func VariationR($iN, $iK)
	If $iK > $iN Then Return 0
	Return $iK^$iN
EndFunc