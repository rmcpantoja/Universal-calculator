#include "globals.au3"
#include "..\mymath\elevar.au3"
#include "..\mymath\fisica.au3"
#include "gui.au3"
#include <GuiButton.au3>
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
						GUICtrlSetData($idInteraccion, "°" & $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Error al convertir los radianes a grados. Asegúrate de que escribiste bien el parámetro, el número de radianes: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay más de un parámetro aquí. Para esta conversión necesitas solamente el número de radianes a convertir. Por favor, dale una rebisada: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "max"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _Max($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "No se ha podido obtener el valor máximo, ya que falta un elemento. Por favor, revise atentamente y vuelva a intentar: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Tienes demás parámetros, recuerda que necesitas solo dos, un número menor y otro mayor para hacer esto. Por favor, verifica: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "min"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _Min($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Falta un parámetro para poder sacar el valor mínimo. Por favor, revisa: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "No se puede sacar el valor mínimo porque tienes demás de los parámetros permitidos en esta función. Revisa y elimina el o los parámetros de sobra si es necesario: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "rad"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = _Radian($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Error de conversión de Grados a Radianes. Revisa bien que tengas el único parámetro, que es el número de grados para convertir a radianes. Revisa lo siguiente: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Tienes dos o más parámetros, por lo que no hace falta. Asegúrate de que tienes solamente el número de grados: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "acc"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _aceleracion($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Fíjate que no falte la velocidad o el tiempo: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Los parámetros son demás. Por favor, revisa: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "acos"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = ACos($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "No se puede calcular el arcocoseno porque no tienes el parámetro requerido: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Para hacer el cálculo del arcocoseno solo necesitamos el número (o la expresión): " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "asin"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = ASin($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "No es posible calcular el arcoseno de este número (expresión) porque falta el parámetro requerido: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Error al realizar el cálculo del arcoseno porque tienes demás parámetros. Asegúrate de que escribiste bien la expresión (sin espacios): " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "atan"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = ATan($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Falta el parámetro que corresponde al número o expresión para obtener el cálculo del arcotangente: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Tienes demás parámetros. Necesitamos tan solo un número o una expresión para calcular el arcotangente: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "cos"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = Cos($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Error al calcular el coseno porque falta el parámetro que contiene el número (o expresión) ¿Podrías revisarlo, por favor?: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Tienes dos o más parámetros, por lo que para calcular el coseno necesitamos un número o una expresión: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "dox"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _D_o_X($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "por favor, revisa que no falta la velocidad o el tiempo: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay parámetros de sobra. Necesitamos oslo la velocidad y el tiempo: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "log"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = Log($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Falta el número o la expresión requerida para calcular el logaritmo: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay demás parámetros. Recuerda que solo necesitas un parámetro que es un número o una expresión, para calcular el logaritmo natural: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "ro"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = Round($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Necesitas el número a redondear para realizar esta función. Por favor revisa y, luego, vuelve a intentar con el comando ya corregido: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay demás parámetros para esta función. Solo necesitas el número para redondear. Por favor, revisa: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "sin"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = Sin($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "No se puede obtener el seno porque falta el número o la expresión: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "NO necesitas otro parámetro más que el valor para aplicar el seno: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "tan"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = Tan($aNumbers[1])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "No se puede calcular la tangente porque falta número o expresión para que esto sea aplicado: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay dos o más parámetros, por lo que solamente necesitas un número o una expresión: " & $sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "ap-a1"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _a1($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión aritmética", "No se puede obtener el término porque faltan elementos. Por favor, rebisa: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "gp-a1"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _a12($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión geométrica", "No se puede obtener el término porque faltan elementos. Por favor, rebisa: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "ap-d"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _Diference($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión aritmética", "No se ha podido obtener la diferencia, porque falta(n) elemento(s) necesarios para esta fórmula. Rebisa por favor: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "gp-r"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _r($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión geométrica", "No se ha podido obtener la razón, porque falta(n) elemento(s) necesarios para esta fórmula. Rebisa por favor: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "ap-n"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _NumTerm($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión aritmética", "No se puede obtener el número de término porque falta(n) elemento(s) necesarios. Por favor, haz una rebisión y trata de corregir: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "gp-n"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _NumTerm2($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión geométrica", "No se puede obtener el número de término porque falta(n) elemento(s) necesarios. Por favor, haz una rebisión y trata de corregir: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "ap-an"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _AN($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión aritmética", "No se puede obtener el término enpesimo porque falta(n) elemento(s) que son necesarios para la fórmula. Considera hacer una rebisión: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "gp-an"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _AN2($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión geométrica", "No se puede obtener el término enpesimo porque falta(n) elemento(s) que son necesarios para la fórmula. Considera hacer una rebisión: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "ap-sn1"
					If _CheckComandParams($aNumbers, 3) Then
						$nResultado = _Sn1($aNumbers[1], $aNumbers[2], $aNumbers[3])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión aritmética", "No se ha podido obtener la suma de términos porque falta(n) elemento(s). Por favor, rebisa e intenta realizar esta operación con los elementos completos de esta fórmula: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión aritmética", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "gp-sn1"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _Sn3($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de progresión geométrica", "No se ha podido obtener la suma de términos porque falta(n) elemento(s). Por favor, rebisa e intenta realizar esta operación con los elementos completos de esta fórmula: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de progresión geométrica", "Tienes demás elementos establecidos que sobran en esta fórmula. Por favor, ajusta el número correcto de parámetros o, si crees que esto es un error, por favor contáctame.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "raise"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _Elevado($aNumbers[1], $aNumbers[2])
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
						;GUICtrlSetData($idPantallaResultados, $aNumbers[1] & " elevado al " & $sTipoElevacion & " es igual a: " & $nResultado)
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de elevación", "No se puede realizar esta operación porque falta el número base o el exponente. Por favor, comprueba e intenta de nuevo: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de elevación", "Tienes demás elementos para resolver esto. Por favor, ajusta bien los parámetros de esta fórmula.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "root"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _Raiz2($aNumbers[1], $aNumbers[2])
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
						;GUICtrlSetData($idPantallaResultados, "La raíz " & $sTipoRaiz & " de " & $aNumbers[2] & ", es igual a: " & $nResultado)
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de raíz", "No se puede realizar esta raíz ya que falta uno de los parámetros. Por favor, considera revisar esto: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de raíz", "Sobran parámetros aquí. Rebisa que no estén más de estos dos parámetros, el número de raíz y el número para obtenerla, ej: raiz:3 4 saca raíz cúbica de 4.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "sr"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = Sqrt($aNumbers[1])
						;GUICtrlSetData($idPantallaResultados, "La raíz cuadrada de " & $aNumbers[1] & ", es igual a: " & $nResultado)
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de raíz", "No se puede realizar esta raíz ya que falta uno de los parámetros. Por favor, considera revisar esto: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de raíz", "Sobran parámetros aquí. Rebisa que no estén más de estos dos parámetros, el número de raíz y el número para obtenerla, ej: raiz:3 4 saca raíz cúbica de 4.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "cr"
					If _CheckComandParams($aNumbers, 1) Then
						$nResultado = cbrt($aNumbers[1])
						;GUICtrlSetData($idPantallaResultados, "La raíz cúbica de " & $aNumbers[1] & ", es igual a: " & $nResultado)
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error de raíz", "No se puede realizar la raíz cúbica ya que falta uno de los parámetros. Por favor, considera revisar esto: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error de raíz", "Sobran parámetros aquí. Recuerda que solo deberás introducir un parámetro, el número con el que hacer la raíz.")
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "time"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _tiempo($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Falta la velocidad o la distancia. Por fafor, corrije: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Hay parámetros de sobra aquí, no necesitas más que la velocidad y la distancia: " &$sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case $aInteraccion[1] = "vel"
					If _CheckComandParams($aNumbers, 2) Then
						$nResultado = _Velocidad($aNumbers[1], $aNumbers[2])
						GUICtrlSetData($idInteraccion, $nResultado)
					ElseIf @error = 1 Then
						MsgBox(16, "Error", "Falta la distancia o el tiempo. Esta es la operación original para que la revises: " & $sInterOperacion)
					ElseIf @error = 2 Then
						MsgBox(16, "Error", "Necesitas solamente la distancia y el tiempo para aplicar esta fórmula, pues tienes parámetros que sobran: " &$sInterOperacion)
					ElseIf @error = 3 Then
						MsgBox(16, "Error de sintaxis", "El parámetro " & @extended & ", " & $aNumbers[@extended] & ", no tiene números.")
					EndIf
				Case Else
					MsgBox(16, "Error", "El comando " & $aInteraccion[1] & " no existe. Si crees que es una función que permita realizar una fórmula matemática, por favor dime para poder agregarla.")
			EndSelect
			GUICtrlSetState($idInteraccion, $GUI_Focus)
		EndIf
	EndIf
EndFunc   ;==>_calc