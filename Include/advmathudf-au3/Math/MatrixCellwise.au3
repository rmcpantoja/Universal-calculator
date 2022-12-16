#include-once

Func MatrixCellwisePower(ByRef $aData, $vPower)
	If UBound($aData, 0) = 1 Then
		Local $aRet[UBound($aData)], $i

		For $i = 0 To (UBound($aData)-1)
			If Not IsArray($vPower) Then
				$aRet[$i] = $aData[$i]^$vPower
			Else
				$aRet[$i] = $aData[$i]^$vPower[$i]
			EndIf
		Next

		Return $aRet
	ElseIf UBound($aData, 0) = 2 Then
		Local $aRet[UBound($aData)][UBound($aData, 2)], $x, $y

		For $x = 0 To (UBound($aData)-1)
			For $y = 0 To (UBound($aData, 2)-1)
				If Not IsArray($vPower) Then
					$aRet[$x][$y] = $aData[$x][$y]^$vPower
				Else
					$aRet[$x][$y] = $aData[$x][$y]^$vPower[$x][$y]
				EndIf
			Next
		Next

		Return $aRet
	EndIf
EndFunc

Func MatrixCellwiseMultiply(ByRef $aData, ByRef $vValue)
	If UBound($aData, 0) = 1 Then
		Local $aRet[UBound($aData)], $i

		For $i = 0 To (UBound($aData)-1)
			If Not IsArray($vValue) Then
				$aRet[$i] = $aData[$i]*$vValue
			Else
				$aRet[$i] = $aData[$i]*$vValue[$i]
			EndIf
		Next

		Return $aRet
	ElseIf UBound($aData, 0) = 2 Then
		Local $aRet[UBound($aData)][UBound($aData, 2)], $x, $y

		For $x = 0 To (UBound($aData)-1)
			For $y = 0 To (UBound($aData, 2)-1)
				If Not IsArray($vValue) Then
					$aRet[$x][$y] = $aData[$x][$y]*$vValue
				Else
					$aRet[$x][$y] = $aData[$x][$y]*$vValue[$x][$y]
				EndIf
			Next
		Next

		Return $aRet
	EndIf
EndFunc
