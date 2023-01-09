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
	$sInterOperacion = GUICtrlRead($idInteraccion)
	If $sInterOperacion = "" And Not _IsFocused($hGUI, $idFORMULAS) Then
		MsgBox(16, "Error", "Debes escribir una operación o seleccionar un comando.")
	ElseIf _IsFocused($hGUI, $idFORMULAS) Then
		; if we have focused the control in the list of commands, what to do:
		$sInterOperacion = CreateParams($idFORMULAS)
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
			GUICtrlSetData($idInteraccion, $sInterOperacion)
			If Not _IsFocused($hGUI, $idInteraccion) Then GUICtrlSetState($idInteraccion, $GUI_Focus)
			_GUICtrlButton_Click($idIgual)
		EndIf
	Else
		; If the user has written an operation with the decimal comma, replace it with point.
		If StringInStr($sInterOperacion, ",") Then $sInterOperacion = StringReplace($sInterOperacion, ",", ".")
		; Now we check if a command has been typed. The key sign for this is the ":" (colon) sign.
		If Not StringInStr($sInterOperacion, ":") Then
			$nResultado = Execute($sInterOperacion)
			If @error Then
				MsgBox(16, "Error", "Ocurrió un error al realizar esta operación. Por favor, mira que la sintaxis esté correcta.")
			Else
				GUICtrlSetData($idInteraccion, $nResultado)
				If Not _IsFocused($hGUI, $idInteraccion) Then GUICtrlSetState($idInteraccion, $GUI_Focus)
			EndIf
		Else
			$aInteraccion = StringSplit($sInterOperacion, ":")
			$aNumbers = StringSplit($aInteraccion[2], " ")
			; convert strings to numbers, which is what it has to be in reality:
			For $I = 1 To $aNumbers[0]
				$aNumbers[$I] = Number($aNumbers[$I])
			Next
			; We make support for commands or formulas available:
			Select
				Case $aInteraccion[1] = "deg"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = _Degree($aNumbers[1])
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Error al convertir los radianes a grados. Asegúrate de que escribiste bien el parámetro, el número de radianes: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay más de un parámetro aquí. Para esta conversión necesitas solamente el número de radianes a convertir. Por favor, dale una rebisada: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "max"
					If _CheckComandParams($aNumbers, 2) Then $nResultado = _Max($aNumbers[1], $aNumbers[2])
				Case $aInteraccion[1] = "min"
					If _CheckComandParams($aNumbers, 2) Then $nResultado = _Min($aNumbers[1], $aNumbers[2])
				Case $aInteraccion[1] = "rad"
					If _CheckComandParams($aNumbers, 1) Then $nResultado = _Radian($aNumbers[1])
				Case $aInteraccion[1] = "acc"
					If _CheckComandParams($aNumbers, 2) Then $nResultado = _aceleracion($aNumbers[1], $aNumbers[2])
				Case $aInteraccion[1] = "acos"
					If _CheckComandParams($aNumbers, 1) Then $nResultado = ACos($aNumbers[1])
				Case $aInteraccion[1] = "asin"
					If _CheckComandParams($aNumbers, 1) Then $nResultado = ASin($aNumbers[1])
				Case $aInteraccion[1] = "atan"
					If _CheckComandParams($aNumbers, 1) Then $nResultado = ATan($aNumbers[1])
				Case $aInteraccion[1] = "cos"
					If _CheckComandParams($aNumbers, 1) Then $nResultado = Cos($aNumbers[1])
				Case $aInteraccion[1] = "dox"
					If _CheckComandParams($aNumbers, 2) Then $nResultado = _D_o_X($aNumbers[1], $aNumbers[2])
				Case $aInteraccion[1] = "log"
					If _CheckComandParams($aNumbers, 1) Then $nResultado = Log($aNumbers[1])
				Case $aInteraccion[1] = "ro"
					If _CheckComandParams($aNumbers, 1) Then $nResultado = Round($aNumbers[1])
				Case $aInteraccion[1] = "sin"
					If _CheckComandParams($aNumbers, 1) Then $nResultado = Sin($aNumbers[1])
				Case $aInteraccion[1] = "tan"
					If _CheckComandParams($aNumbers, 1) Then $nResultado = Tan($aNumbers[1])
				Case $aInteraccion[1] = "ap-a1"
					If _CheckComandParams($aNumbers, 3) Then $nResultado = _a1($aNumbers[1], $aNumbers[2], $aNumbers[3])
				Case $aInteraccion[1] = "gp-a1"
					If _CheckComandParams($aNumbers, 3) Then $nResultado = _a12($aNumbers[1], $aNumbers[2], $aNumbers[3])
				Case $aInteraccion[1] = "ap-d"
					If _CheckComandParams($aNumbers, 3) Then $nResultado = _Diference($aNumbers[1], $aNumbers[2], $aNumbers[3])
				Case $aInteraccion[1] = "gp-r"
					If _CheckComandParams($aNumbers, 3) Then $nResultado = _r($aNumbers[1], $aNumbers[2], $aNumbers[3])
				Case $aInteraccion[1] = "ap-n"
					If _CheckComandParams($aNumbers, 3) Then $nResultado = _NumTerm($aNumbers[1], $aNumbers[2], $aNumbers[3])
				Case $aInteraccion[1] = "gp-n"
					If _CheckComandParams($aNumbers, 3) Then $nResultado = _NumTerm2($aNumbers[1], $aNumbers[2], $aNumbers[3])
				Case $aInteraccion[1] = "ap-an"
					If _CheckComandParams($aNumbers, 3) Then $nResultado = _AN($aNumbers[1], $aNumbers[2], $aNumbers[3])
				Case $aInteraccion[1] = "gp-an"
					If _CheckComandParams($aNumbers, 3) Then $nResultado = _AN2($aNumbers[1], $aNumbers[2], $aNumbers[3])
				Case $aInteraccion[1] = "ap-sn1"
					If _CheckComandParams($aNumbers, 3) Then $nResultado = _Sn1($aNumbers[1], $aNumbers[2], $aNumbers[3])
				Case $aInteraccion[1] = "gp-sn1"
					If _CheckComandParams($aNumbers, 2) Then $nResultado = _Sn3($aNumbers[1], $aNumbers[2])
				Case $aInteraccion[1] = "raise"
					If _CheckComandParams($aNumbers, 2) Then $nResultado = _Elevado($aNumbers[1], $aNumbers[2])
					Switch $aNumbers[2]
						Case 2
							$sTipoElevacion = "cuadrado"
						Case 3
							$sTipoElevacion = "cubo"
						Case 4
							$sTipoElevacion = "cuarto"
						Case 5
							$sTipoElevacion = "quinto"
						Case 6
							$sTipoElevacion = "sexto"
						Case 7
							$sTipoElevacion = "septimo"
						Case 8
							$sTipoElevacion = "octavo"
						Case 9
							$sTipoElevacion = "noveno"
					EndSwitch
				Case $aInteraccion[1] = "root"
					If _CheckComandParams($aNumbers, 2) Then $nResultado = _Raiz2($aNumbers[1], $aNumbers[2])
					Switch $aNumbers[1]
						Case 2
							$sTipoRaiz = "cuadrada"
						Case 3
							$sTipoRaiz = "cúbica"
						Case 4
							$sTipoRaiz = "cuarta"
						Case 5
							$sTipoRaiz = "quinta"
						Case 6
							$sTipoRaiz = "sexta"
						Case 7
							$sTipoRaiz = "Séptima"
						Case 8
							$sTipoRaiz = "octaba"
						Case 9
							$sTipoRaiz = "novena"
					EndSwitch
				Case $aInteraccion[1] = "sr"
					If _CheckComandParams($aNumbers, 1) Then $nResultado = Sqrt($aNumbers[1])
				Case $aInteraccion[1] = "cr"
					If _CheckComandParams($aNumbers, 1) Then $nResultado = cbrt($aNumbers[1])
				Case $aInteraccion[1] = "time"
					If _CheckComandParams($aNumbers, 2) Then $nResultado = _tiempo($aNumbers[1], $aNumbers[2])
				Case $aInteraccion[1] = "vel"
					If _CheckComandParams($aNumbers, 2) Then $nResultado = _Velocidad($aNumbers[1], $aNumbers[2])
				Case Else
					MsgBox(16, "Error", "El comando " & $aInteraccion[1] & " no existe. Si crees que es una función que permita realizar una fórmula matemática, por favor dime para poder agregarla.")
			EndSelect
			if not @error then
				GUICtrlSetData($idInteraccion, $nResultado)
				GUICtrlSetState($idInteraccion, $GUI_Focus)
			Else
				switch @error
					case 1
						MsgBox(16, "Error", "Ha ocurrido un error al realizar esta operación. Faltan uno o más números requeridos para ejecutarla. Por favor, revísalo y vuelve a ejecutar esta fórmula cuando hayas corregido los elementos. Estructura: " & $sInterOperacion)
					case 2
						MsgBox(16, "Error", "Hay más de un parámetro aquí. Por favor, elimina los parámetros que sobran e inténtalo nuevamente. operación: " & $sInterOperacion)
					case 3
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
				EndSwitch
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_calc