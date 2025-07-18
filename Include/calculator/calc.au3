#include "..\mymath\average.au3"
#include "globals.au3"
#include "..\mymath\elevar.au3"
#include "..\mymath\fisica.au3"
#include "globals.au3"
#include "gui.au3"
#include <GuiButton.au3>
#include "keyboard.au3"
#include "..\advmathudf-au3\Math\Logarithms.au3"
#include <Math.au3>
;#include "..\advmathudf-au3\Math.au3"
#include "..\miscstring.au3"
#include "..\mymath\percent.au3"
#include "..\mymath\perimeter.au3"
#include "..\mymath\peso.au3"
#include "..\mymath\Progresiones.au3"
#include "..\mymath\raiz.au3"
#include "..\advmathudf-au3\Math\Roots.au3"
#include "..\translator.au3"
#include-once

; #FUNCTION# ====================================================================================================================
; Name ..........: _calc
; Description ...: base function of the program
; Syntax ........: _calc($hGUI, $idFORMULAS, $idInter)
; Parameters ....: $hGUI                - the handler that contains the GUI of the program.
;                  $idFORMULAS          - The ID of the formula list control.
;                  $idInter             - the ID of the interaction inputbox control.
;                  $idEqual             - the ID of the equal button control.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _calc($hGUI, $idFORMULAS, $idInter, $idEqual)
	$sOperation = GUICtrlRead($idInter)
	; recently, I discovered that "execute" can run script functions too. Only mathematical functions can be executed here, so:
	; Todo: I can make my own parser for math and basic operations.
	If _
			StringInStr($sOperation, '("') _
			Or StringInStr($sOperation, '( "') _
			Or StringInStr($sOperation, "('") _
			Or StringInStr($sOperation, "( '") _
			Or StringInStr($sOperation, '($') _
			Or StringInStr($sOperation, '( $') _
			Then
		MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "You can not do this."))
	ElseIf _String_EndsWith($sOperation, "/0") Then
		; Fix division by 0:
		MsgBox(16, Translate($sLang, "Math error"), Translate($sLang, "Couldn't divide by 0."))
	ElseIf $sOperation = "" And Not _IsFocused($hGUI, $idFORMULAS) Then
		MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "You must type an operation or select a command."))
	ElseIf _IsFocused($hGUI, $idFORMULAS) Then
		; if we have focused the control in the list of commands, what to do:
		If $sFormulaAutocompletion = "1" Then
			$sOperation = CreateParams($idFORMULAS)
		Else
			$sOperation = Autocomplete_and_put($idFORMULAS)
		EndIf
		If @error Then
			Switch @error
				Case 1
					MsgBox(16, _
							Translate($sLang, "Error"), _
							Translate($sLang, "The list doesn't have enough columns to perform this operation.") _
							)
				Case 2
					MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "You have not selected any formula from the list."))
				Case 3
					MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "The specified parameter table is incorrect."))
				Case 4
					MsgBox(16, _
							Translate($sLang, "Error"), _
							Translate($sLang, "An attempt has been made to look for this formula in the formula table, however, it cannot be found.") _
							)
				Case 5
					MsgBox(16, _
							Translate($sLang, "Error"), _
							Translate($sLang, "The application window of this formula has been closed and it could not be applied.") _
							)
				Case 6
					MsgBox(16, _
							Translate($sLang, "Error"), _
							Translate($sLang, "You must fill in all the parameters to proceed to apply this formula. For now, this function has not been applied.") _
							)
			EndSwitch
		Else
			; Adds the command in the field, if it is not focused it does so and clicks the same button automatically to get the result.
			GUICtrlSetData($idInter, $sOperation)
			If Not _IsFocused($hGUI, $idInter) Then GUICtrlSetState($idInter, $GUI_Focus)
			If $sFormulaAutocompletion = "1" Then _GUICtrlButton_Click($idEqual)
		EndIf
	Else
		; If the user has written an operation with the decimal comma, replace it with point.
		If StringInStr($sOperation, ",") Then $sOperation = StringReplace($sOperation, ",", ".")
		; Now we check if a command has been typed. The key sign for this is the ":" (colon) sign.
		If Not StringInStr($sOperation, ":") Then
			If Not _is_math_operation($sOperation) And UBound($aStoreOperators) > 2 Then
				$sOperation = $sOperation & $aStoreOperators[UBound($aStoreOperators) - 2] & $aStoreOperators[UBound($aStoreOperators) - 1]
			Else
				$aStoreOperators = _split_math_operators($sOperation)
			EndIf
			$nResult = Execute($sOperation)
			If @error Then
				MsgBox(16, _
						Translate($sLang, "Error"), _
						Translate($sLang, "An error occurred while doing this operation. Please check that the syntax is correct.") _
						)
			Else
				GUICtrlSetData($idInter, $nResult)
				If $sEnhancedAccessibility = "Yes" Then
					If $sSpeak_result = "yes" Then
						Speaking($nResult, True)
					EndIf
				EndIf
				If Not _IsFocused($hGUI, $idInter) Then GUICtrlSetState($idInter, $GUI_Focus)
			EndIf
		Else
			_interact($sOperation, $idInter)
		EndIf
	EndIf
EndFunc   ;==>_calc

; #FUNCTION# ====================================================================================================================
; Name ..........: _interact
; Description ...: Function that handles the interaction of calculator commands
; Syntax ........: _interact($sOperation, $idInter)
; Parameters ....: $sOperation          - the string containing the command.
;                  $idInter             - the interaction text box.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _interact($sOperation, $idInter)
	$aSplitCMD = StringSplit($sOperation, ":")
	$aNumbers = StringSplit($aSplitCMD[2], " ")
	; convert strings to numbers, which is what it has to be in reality:
	For $I = 1 To $aNumbers[0]
		$aNumbers[$I] = Number($aNumbers[$I])
	Next
	; We make support for commands or formulas available:
	Select
		Case $aSplitCMD[1] = "abs"
			If _CheckComandParams($aNumbers, 1) Then $nResult = Abs($aNumbers[1])
		Case $aSplitCMD[1] = "av"
			_ArrayDelete($aNumbers, 0)
			If UBound($aNumbers) > 1 And $aNumbers[0] > 0 Then
				$nResult = _average($aNumbers)
			Else
				MsgBox(16, _
						Translate($sLang, "Error"), _
						Translate($sLang, "There are no parametters or average:number has only one parametter") _
						)
			EndIf
		Case $aSplitCMD[1] = "bmi"
			If _CheckComandParams($aNumbers, 2) Then $nResult = _IMC($aNumbers[1], $aNumbers[2])
		Case $aSplitCMD[1] = "deg"
			If _CheckComandParams($aNumbers, 1) Then $nResult = _Degree($aNumbers[1])
		Case $aSplitCMD[1] = "max"
			If _CheckComandParams($aNumbers, 2) Then $nResult = _Max($aNumbers[1], $aNumbers[2])
		Case $aSplitCMD[1] = "min"
			If _CheckComandParams($aNumbers, 2) Then $nResult = _Min($aNumbers[1], $aNumbers[2])
		Case $aSplitCMD[1] = "rad"
			If _CheckComandParams($aNumbers, 1) Then $nResult = _Radian($aNumbers[1])
		Case $aSplitCMD[1] = "acc"
			If _CheckComandParams($aNumbers, 2) Then $nResult = _aceleracion($aNumbers[1], $aNumbers[2])
		Case $aSplitCMD[1] = "acos"
			If _CheckComandParams($aNumbers, 1) Then $nResult = ACos($aNumbers[1])
		Case $aSplitCMD[1] = "asin"
			If _CheckComandParams($aNumbers, 1) Then $nResult = ASin($aNumbers[1])
		Case $aSplitCMD[1] = "atan"
			If _CheckComandParams($aNumbers, 1) Then $nResult = ATan($aNumbers[1])
		Case $aSplitCMD[1] = "pc"
			If _CheckComandParams($aNumbers, 2) Then $nResult = _PerimeterCalculation($aNumbers[1], $aNumbers[2])
		Case $aSplitCMD[1] = "cos"
			If _CheckComandParams($aNumbers, 1) Then $nResult = Cos($aNumbers[1])
		Case $aSplitCMD[1] = "dox"
			If _CheckComandParams($aNumbers, 2) Then $nResult = _D_o_X($aNumbers[1], $aNumbers[2])
		Case $aSplitCMD[1] = "log"
			If _CheckComandParams($aNumbers, 1) Then $nResult = Log($aNumbers[1])
		Case $aSplitCMD[1] = "nl"
			If _CheckComandParams($aNumbers, 2) Then $nResult = LogN($aNumbers[1], $aNumbers[2])
		Case $aSplitCMD[1] = "ro"
			If _CheckComandParams($aNumbers, 1) Then $nResult = Round($aNumbers[1])
		Case $aSplitCMD[1] = "sin"
			If _CheckComandParams($aNumbers, 1) Then $nResult = Sin($aNumbers[1])
		Case $aSplitCMD[1] = "tan"
			If _CheckComandParams($aNumbers, 1) Then $nResult = Tan($aNumbers[1])
		Case $aSplitCMD[1] = "ap-a1"
			If _CheckComandParams($aNumbers, 3) Then $nResult = _a1($aNumbers[1], $aNumbers[2], $aNumbers[3])
		Case $aSplitCMD[1] = "gp-a1"
			If _CheckComandParams($aNumbers, 3) Then $nResult = _a12($aNumbers[1], $aNumbers[2], $aNumbers[3])
		Case $aSplitCMD[1] = "ap-d"
			If _CheckComandParams($aNumbers, 3) Then $nResult = _Diference($aNumbers[1], $aNumbers[2], $aNumbers[3])
		Case $aSplitCMD[1] = "gp-r"
			If _CheckComandParams($aNumbers, 3) Then $nResult = _r($aNumbers[1], $aNumbers[2], $aNumbers[3])
		Case $aSplitCMD[1] = "ap-n"
			If _CheckComandParams($aNumbers, 3) Then $nResult = _NumTerm($aNumbers[1], $aNumbers[2], $aNumbers[3])
		Case $aSplitCMD[1] = "gp-n"
			If _CheckComandParams($aNumbers, 3) Then $nResult = _NumTerm2($aNumbers[1], $aNumbers[2], $aNumbers[3])
		Case $aSplitCMD[1] = "ap-an"
			If _CheckComandParams($aNumbers, 3) Then $nResult = _AN($aNumbers[1], $aNumbers[2], $aNumbers[3])
		Case $aSplitCMD[1] = "gp-an"
			If _CheckComandParams($aNumbers, 3) Then $nResult = _AN2($aNumbers[1], $aNumbers[2], $aNumbers[3])
		Case $aSplitCMD[1] = "ap-sn1"
			If _CheckComandParams($aNumbers, 3) Then $nResult = _Sn1($aNumbers[1], $aNumbers[2], $aNumbers[3])
		Case $aSplitCMD[1] = "gp-sn1"
			If _CheckComandParams($aNumbers, 2) Then $nResult = _Sn3($aNumbers[1], $aNumbers[2])
		Case $aSplitCMD[1] = "raise"
			If _CheckComandParams($aNumbers, 2) Then
				$nResult = _Elevado($aNumbers[1], $aNumbers[2])
				Switch $aNumbers[2]
					Case 2
						$sRaiseType = "cuadrado"
					Case 3
						$sRaiseType = "cubo"
					Case 4
						$sRaiseType = "cuarto"
					Case 5
						$sRaiseType = "quinto"
					Case 6
						$sRaiseType = "sexto"
					Case 7
						$sRaiseType = "septimo"
					Case 8
						$sRaiseType = "octavo"
					Case 9
						$sRaiseType = "noveno"
				EndSwitch
			EndIf
		Case $aSplitCMD[1] = "rand"
			If _CheckComandParams($aNumbers, 2) Then $nResult = Random($aNumbers[1], $aNumbers[2], 1)
		Case $aSplitCMD[1] = "root"
			If _CheckComandParams($aNumbers, 2) Then $nResult = _Raiz2($aNumbers[1], $aNumbers[2])
			Switch $aNumbers[1]
				Case 2
					$sRootType = "cuadrada"
				Case 3
					$sRootType = "cúbica"
				Case 4
					$sRootType = "cuarta"
				Case 5
					$sRootType = "quinta"
				Case 6
					$sRootType = "sexta"
				Case 7
					$sRootType = "Séptima"
				Case 8
					$sRootType = "octaba"
				Case 9
					$sRootType = "novena"
			EndSwitch
		Case $aSplitCMD[1] = "sr"
			If _CheckComandParams($aNumbers, 1) Then $nResult = Sqrt($aNumbers[1])
		Case $aSplitCMD[1] = "cr"
			If _CheckComandParams($aNumbers, 1) Then $nResult = cbrt($aNumbers[1])
		Case $aSplitCMD[1] = "time"
			If _CheckComandParams($aNumbers, 2) Then $nResult = _tiempo($aNumbers[1], $aNumbers[2])
		Case $aSplitCMD[1] = "vel"
			If _CheckComandParams($aNumbers, 2) Then $nResult = _Velocidad($aNumbers[1], $aNumbers[2])
		Case $aSplitCMD[1] = "per"
			If _CheckComandParams($aNumbers, 2) Then
				$aPercentArray = _percent($aNumbers[1], $aNumbers[2])
				$nResult = $aPercentArray[1]
			EndIf
		Case Else
			MsgBox(16, _
					Translate($sLang, "Error"), _
					Translate($sLang, "The command") & " " & $aSplitCMD[1] & " " & Translate($sLang, "does not exist. If you think it is a function that allows you to perform a mathematical formula, please tell us so we can add it.") _
					)
	EndSelect
	If Not @error Then
		GUICtrlSetData($idInter, $nResult)
		If Not _IsFocused($hGUI, $idInter) Then GUICtrlSetState($idInter, $GUI_Focus)
		If $sEnhancedAccessibility = "Yes" Then
			If $sSpeak_result = "Yes" Then
				Speaking($nResult, True)
			EndIf
		EndIf
	Else
		Switch @error
			Case 1
				MsgBox(16, _
						Translate($sLang, "Error"), _
						Translate($sLang, "An error occurred while doing this operation. One or more numbers required to run are missing. Please review it and run this formula again when you have fixed the items. Structure:") & " " & $sOperation _
						)
			Case 2
				MsgBox(16, _
						Translate($sLang, "Error"), _
						Translate($sLang, "There's more than one parameter here. Please remove the extra parameters and try again. operation:") & " " & $sOperation _
						)
			Case 3
				MsgBox(16, _
						Translate($sLang, "syntax error"), _
						Translate($sLang, "The parameter") & " " & @extended & ", " & $aNumbers[@extended] & ", " & Translate($sLang, "has no numbers.") _
						)
		EndSwitch
	EndIf
EndFunc   ;==>_interact
