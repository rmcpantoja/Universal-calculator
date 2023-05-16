#include "Task_creator.au3"

#include-once

; #FUNCTION# ====================================================================================================================
; Name ..........: _count_math_Operators
; Description ...: Count each of the operators in a mathematical operation.
; Syntax ........: _count_math_Operators($sString)
; Parameters ....: $sString             - A string containing the operation to perform (for example: 2+2*4).
; Return values .: A 2d array. In the first column the number of operators found, and in the second the operator.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _count_math_Operators($sString)
	Local $iResult
	Local $sCurrent, $sCurrentOperators
	Local $aResults[0][2]
	$sCurrentOperators = _regexOcurrence($sString, "|1234567890")
	For $I = 0 To StringLen($sOperators) - 1
		$sCurrent = StringMid($sOperators, $I + 1, 1)
		$iResult = Int(_get_number_of_ocurrences($sCurrentOperators, $sCurrent))
		If Not $iResult = 0 Then
			ReDim $aResults[UBound($aResults, 1) + 1][UBound($aResults, 2)]
			$aResults[$I][0] = $iResult
			$aResults[$I][1] = $sCurrent
		EndIf
	Next
	Return $aResults
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _get_math_Operators
; Description ...: gets only the operators of a mathematical function.
; Syntax ........: _get_math_Operators($sString)
; Parameters ....: $sString             - The string containing the math operation.
; Return values .: An array with all the operators found.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _get_math_Operators($sString)
	Local $aResults[1]
	Local $iIndex = -1

	For $i = 1 To StringLen($sString)
		Local $sCurrent = StringMid($sString, $i, 1)

		If StringRegExp($sCurrent, "[+\-*/]") Then
			$iIndex += 1
			ReDim $aResults[$iIndex + 1]
			$aResults[$iIndex] = $sCurrent
		EndIf
	Next

	Return $aResults
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _split_math_operators
; Description ...: Divide and/or decompose the mathematical operation. The divisors are the operators that are (+, -, *, /, ^).
; Syntax ........: _split_math_operators($sOperation)
; Parameters ....: $sOperation          - A string containing the operation to split.
; Return values .: A 1d array with the splitted operation.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _split_math_operators($sOperation)
	if not IsString($sOperation) then Return SetError(1, 0, "")
	Local $aResult = StringRegExp($sOperation, "([\d\.]+)|([+|\-|*|/|^])", 3)
	__CleanArray($aResult)
	Return $aResult
EndFunc

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __CleanArray
; Description ...: This function checks if there is an blank or empty element inside the array. If so, it deletes it.
; Syntax ........: __CleanArray(Byref $aArray)
; Parameters ....: $aArray			  - [in/out] The array to be fixed.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __CleanArray(ByRef $aArray)
	If Not IsArray($aArray) Then Return SetError(1, 0, "")
	For $I = 0 To UBound($aArray) - 1
		If UBound($aArray) = $I+1 Then ExitLoop
		If $aArray[$I] = "" Then
			_ArrayDelete($aArray, $I)
			If @error Then
				ExitLoop
				Return SetError(@error, 0, "")
			EndIf
			$I = $I - 1
		Else
			ContinueLoop
		EndIf
	Next
	;_ArrayDelete($aArray, UBound($aArray) - 1)
EndFunc   ;==>__CleanArray
