#include-once

Func Integral($fnFunction, $vStart = 0, $vEnd = 1, $vIntegrationVariable = 0.001, $aAdditionalParams = 0, $iMode = $M_INTEGRATE_SIMPSON)
	; Check if the integral is improper (infinite range)
	If $vStart = -$Infinity And $vEnd = $Infinity Then
		Local $aParams = [$fnFunction, $aAdditionalParams]
		Return Integral(__IntegralMinfToInf, 0, 1, $vIntegrationVariable, $aParams, $iMode)
	ElseIf $vStart = -$Infinity Then
		Local $aParams = [$fnFunction, $aAdditionalParams, $vEnd]
		Return Integral(__IntegralMinfToFixed, 0, 1, $vIntegrationVariable, $aParams, $iMode)
	ElseIf $vEnd = $Infinity Then
		Local $aParams = [$fnFunction, $aAdditionalParams, $vStart]
		Return Integral(__IntegralFixedToInf, 0, 1, $vIntegrationVariable, $aParams, $iMode)
	EndIf

	If IsFunc($fnFunction) Then $fnFunction = FuncName($fnFunction)

	Local $sum = 0
	Local $a, $b
	Local $i, $h
	Local $n = ($vEnd-$vStart)/$vIntegrationVariable

	Switch $iMode
		Case $M_INTEGRATE_TRAPEZOID
			$a = Call($fnFunction, $vStart)

			For $i = ($vStart + $vIntegrationVariable) To $vEnd Step $vIntegrationVariable
				$b = __IntegralCall($fnFunction, $i, $aAdditionalParams)
				$sum += 0.5 * ($a+$b) * $vIntegrationVariable

				$a = $b
			Next
		Case $M_INTEGRATE_SIMPSON
			$h = ($vEnd-$vStart)/(2*$n)
			$sum += __IntegralCall($fnFunction, $vStart, $aAdditionalParams)

			For $i = 1 To (2*$n-1) Step +2
				$sum += 4*__IntegralCall($fnFunction, $vStart+$i*$h, $aAdditionalParams)
			Next

			For $i = 2 To (2*$n-2) Step +2
				$sum += 2*__IntegralCall($fnFunction, $vStart+$i*$h, $aAdditionalParams)
			Next

			$sum += __IntegralCall($fnFunction, $vEnd, $aAdditionalParams)

			$sum *= $h/3
	EndSwitch

	Return $sum
EndFunc

Func __IntegralMinfToInf($fX, $aAdditionalParams)
	Return (__IntegralCall($aAdditionalParams[0], (1-$fX)/$fX, $aAdditionalParams[1]) + __IntegralCall($aAdditionalParams[0], -(1-$fX)/$fX, $aAdditionalParams[1]))/($fX^2)
EndFunc

Func __IntegralMinfToFixed($fX, $aAdditionalParams)
	Return __IntegralCall($aAdditionalParams[0], $aAdditionalParams[2] - (1-$fX)/$fX, $aAdditionalParams[1])/($fX^2)
EndFunc

Func __IntegralFixedToInf($fX, $aAdditionalParams)
	Return __IntegralCall($aAdditionalParams[0], $aAdditionalParams[2] + (1-$fX)/$fX, $aAdditionalParams[1])/($fX^2)
EndFunc

Func __IntegralCall($fnFunction, $fX, $aAdditionalParams = 0)
	If IsArray($aAdditionalParams) Then
		Return Call($fnFunction, $fX, $aAdditionalParams)
	Else
		Return Call($fnFunction, $fX)
	EndIf
EndFunc