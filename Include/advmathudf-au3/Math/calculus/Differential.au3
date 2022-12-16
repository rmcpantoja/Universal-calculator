#include-once

Func Differential($fnFunction, $vValue, $fDelta = 0.001, $aAdditionalParams = 0)
	If IsFunc($fnFunction) Then $fnFunction = FuncName($fnFunction)

	Local $vValue1, $vValue2

	If IsArray($aAdditionalParams) Then
		$vValue1 = Call($fnFunction, $vValue - $fDelta / 2, $aAdditionalParams)
		$vValue2 = Call($fnFunction, $vValue + $fDelta / 2, $aAdditionalParams)
	Else
		$vValue1 = Call($fnFunction, $vValue - $fDelta / 2)
		$vValue2 = Call($fnFunction, $vValue + $fDelta / 2)
	EndIf

	Return ($vValue2-$vValue1)/$fDelta
EndFunc

Func Differential2($fnFunction, $vValue, $fDelta = 0.001)
	If IsFunc($fnFunction) Then $fnFunction = FuncName($fnFunction)

	Local $point1 = Point($vValue - $fDelta / 2, Call($fnFunction, $vValue - $fDelta / 2))
	Local $point2 = Point($vValue + $fDelta / 2, Call($fnFunction, $vValue + $fDelta / 2))

	Return Tan(AngleBetweenPoints($point1, $point2))
EndFunc

