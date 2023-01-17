#include "globals.au3"
#include "..\mymath\elevar.au3"
#include "..\mymath\fisica.au3"
#include "gui.au3"
#include <GuiButton.au3>
#include "keyboard.au3"
#include <Math.au3>
;#include "..\advmathudf-au3\Math.au3"
#include "..\mymath\Progresiones.au3"
#include "..\mymath\raiz.au3"
#include "..\advmathudf-au3\Math\Roots.au3"
#include "..\translator.au3"
#include-once

; #FUNCTION# ====================================================================================================================
; Name ..........: _calc
; Description ...:
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
		MsgBox(16, "Error", "Debes escribir una operación o seleccionar un comando.")
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
					MsgBox(16, "Error", "La lista no requiere con las columnas necesarias para interactuar.")
				Case 2
					MsgBox(16, "Error", "No has seleccionado ninguna fórmula de la lista.")
				Case 3
					MsgBox(16, "Error", "La tabla de parámetros especificada es incorrecta.")
				Case 4
					MsgBox(16, "Error", "Se ha tratado de buscar esta fórmula en la tabla de fórmulas, sin envargo, no se encuentra.")
				Case 5
					MsgBox(16, "Error", "La ventana de aplicación de esta fórmula se ha cerrado y esta no ha podido ser aplicada.")
				Case 6
					MsgBox(16, "Error", "Debes rellenar todos los parámetros para proceder a aplicar esta fórmula. Por ahora, esta función no se ha aplicado.")
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
				MsgBox(16, "Error", "Ocurrió un error al realizar esta operación. Por favor, mira que la sintaxis esté correcta.")
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
					MsgBox(16, "Error", "El comando " & $aSplitCMD[1] & " no existe. Si crees que es una función que permita realizar una fórmula matemática, por favor dime para poder agregarla.")
			EndSelect
			if not @error then
				GUICtrlSetData($idInter, $nResult)
				GUICtrlSetState($idInter, $GUI_Focus)
			Else
				switch @error
					case 1
						MsgBox(16, "Error", "Ha ocurrido un error al realizar esta operación. Faltan uno o más números requeridos para ejecutarla. Por favor, revísalo y vuelve a ejecutar esta fórmula cuando hayas corregido los elementos. Estructura: " & $sOperation)
					case 2
						MsgBox(16, "Error", "Hay más de un parámetro aquí. Por favor, elimina los parámetros que sobran e inténtalo nuevamente. operación: " & $sOperation)
					case 3
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
				EndSwitch
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_calc