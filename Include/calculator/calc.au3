#include "globals.au3"
#include "..\mymath\elevar.au3"
#include "..\mymath\fisica.au3"
#include "globals.au3"
#include "gui.au3"
#include <GuiButton.au3>
#include "keyboard.au3"
#include <Math.au3>
;#include "..\advmathudf-au3\Math.au3"
#include "..\mymath\perimeter.au3"
#include "..\mymath\Progresiones.au3"
#include "..\mymath\raiz.au3"
#include "..\advmathudf-au3\Math\Roots.au3"
#include "..\translator.au3"
#include-once

; #FUNCTION# ====================================================================================================================
; Name ..........: _calc
; Description ...: This is the base function for this program.
; Syntax ........: _calc()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _calc()
	$sOperation = GUICtrlRead($idInter)
	If $sOperation = "" And Not _IsFocused($hGUI, $idFORMULAS) Then
		MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "You must type an operation or select a command."))
	ElseIf _IsFocused($hGUI, $idFORMULAS) Then
		; if we have focused the control in the list of commands, what to do:
		if $sFormulaAutocompletion = "1" then
			$sOperation = CreateParams($idFORMULAS)
		Else
			$sOperation = Autocomplete_and_put($idFORMULAS)
		EndIf
		If @error Then
			Switch @error
				Case 1
					MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "The list doesn't require with the necessary columns to interact."))
				Case 2
					MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "You have not selected any formula from the list."))
				Case 3
					MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "The specified parameter table is incorrect."))
				Case 4
					MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "An attempt has been made to look for this formula in the formula table, however, it cannot be found."))
				Case 5
					MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "The application window of this formula has been closed and it could not be applied."))
				Case 6
					MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "You must fill in all the parameters to proceed to apply this formula. For now, this function has not been applied."))
			EndSwitch
		Else
			; Adds the command in the field, if it is not focused it does so and clicks the same button automatically to get the result.
			GUICtrlSetData($idInter, $sOperation)
			If Not _IsFocused($hGUI, $idInter) Then GUICtrlSetState($idInter, $GUI_Focus)
			if $sFormulaAutocompletion = "1" then _GUICtrlButton_Click($idEqual)
		EndIf
	Else
		; If the user has written an operation with the decimal comma, replace it with point.
		If StringInStr($sOperation, ",") Then $sOperation = StringReplace($sOperation, ",", ".")
		; Now we check if a command has been typed. The key sign for this is the ":" (colon) sign.
		If Not StringInStr($sOperation, ":") Then
			$nResult = Execute($sOperation)
			If @error Then
				MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "An error occurred while doing this operation. Please check that the syntax is correct."))
			Else
				GUICtrlSetData($idInter, $nResult)
				If Not _IsFocused($hGUI, $idInter) Then GUICtrlSetState($idInter, $GUI_Focus)
			EndIf
		Else
			$aSplitCMD = StringSplit($sOperation, ":")
			$aNumbers = StringSplit($aSplitCMD[2], " ")
			; convert strings to numbers, which is what it has to be in reality:
			For $I = 1 To $aNumbers[0]
				$aNumbers[$I] = Number($aNumbers[$I])
			Next
			; We make support for commands or formulas available:
			Select
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
					If _CheckComandParams($aNumbers, 2) Then $nResult = _Elevado($aNumbers[1], $aNumbers[2])
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
				Case Else
					MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "The command") &" " & $aSplitCMD[1] & " " &Translate($sLang, "does not exist. If you think it is a function that allows you to perform a mathematical formula, please tell me so I can add it."))
			EndSelect
			if not @error then
				GUICtrlSetData($idInter, $nResult)
				GUICtrlSetState($idInter, $GUI_Focus)
			Else
				switch @error
					case 1
						MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "An error occurred while doing this operation. One or more numbers required to run are missing. Please review it and run this formula again when you have fixed the items. Structure:") &" " & $sOperation)
					case 2
						MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "There's more than one parameter here. Please remove the extra parameters and try again. operation:") &" " & $sOperation)
					case 3
						MsgBox(16, Translate($sLang, "syntax error"), Translate($sLang, "The parameter") &" " & @extended & ", " & $aNumbers[@extended] & ", " &Translate($sLang, "has no numbers."))
				EndSwitch
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_calc