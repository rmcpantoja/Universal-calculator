#include "formulas.au3"
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _CheckComandParams
; Description ...:
; Syntax ........: _CheckComandParams($nParams)
; Parameters ....: $nParams             - a general number value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _CheckComandParams($aNumbers, $nParams)
	;ToDo: Si es verdadero, bien, seguir con true. Pero si es falso, retornar @error en. 1 si el número de parámetros que se estableció es menor al establecido, y 2 si en cambio es mayor. Hecho.
	If $aNumbers[0] = $nParams Then
		Return True
	ElseIf $aNumbers[0] < $nParams Then
		SetError(1, 0, "The num params is minor tan established param.")
	ElseIf $aNumbers[0] > $nParams Then
		SetError(2, 0, "The num params is major tan established param.")
	Else
		For $I = 1 To $aNumbers[0]
			If Not IsNumber($aNumbers[$I]) Then Return SetError(3, $I, "Parameter " & $I & ", " & $aNumbers[$I] & ", is not a number.")
		Next
	EndIf
EndFunc   ;==>_CheckComandParams
; #FUNCTION# ====================================================================================================================
; Name ..........: _SearchParam
; Description ...:
; Syntax ........: _SearchParam($sFormula[, $aFormTable = Default[, $bReturnFormList = False]])
; Parameters ....: $sFormula            - a string value.
;                  $aFormTable          - [optional] an array of unknowns. Default is Default.
;                  $bReturnFormList     - [optional] a boolean value. Default is False.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _SearchParam($sFormula, $aFormTable = Default, $bReturnFormList = False)
	If $aFormTable = Default Then
		Local $aFormList[][] = _get_formule_table()
	Else
		If Not IsArray($aFormList) Then
			SetError(1, 0, "")
		Else
			Local $aFormList = $aFormTable
		EndIf
	EndIf
	If $bReturnFormList And $aFormTable = Default Then
		Return $aFormList
	Else
		For $I = 0 To UBound($aFormList, 1) - 1
			If $sFormula = $aFormList[$I][0] Then
				Return $aFormList[$I][1]
				ExitLoop
			EndIf
			Sleep(10)
		Next
		Return SetError(2, 0, "")
	EndIf
EndFunc   ;==>_SearchParam

