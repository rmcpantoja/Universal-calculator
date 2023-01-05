#include "globals.au3"
#include "..\mymath\raiz.au3"
; #FUNCTION# ====================================================================================================================
; Name ..........: _GetReason
; Description ...:
; Syntax ........: _GetReason()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GetReason()
	;ToDo: Reducir el código haciendo una matriz de los números ordinales en vez del switch que los contiene, y hacer un for. Durante ese ciclo for, se comprueba: si ese número está en los parámetros donde se muestren con números ordinales, se establece, o en $sTipoElevacion o en $sTipoRaiz. Pero sí, para reducir código será una sola matriz con los números ordinales que se manipulará en una operación x. Si se necesitan solo femeninas, será solo una matriz 1d, pero si se necesitan masculinas entonces toca hacer una matriz 2d. Yay, qué difícil soy. Pero mejora mucho el rendimiento y el código ¿Eh?
	;ToDo #2: agregar más números ordinales. Décimo, onceabo, doceabo...
	If GUICtrlRead($idInteraccion) = "" Then
		MsgBox(16, "Error", "Debes escribir un comando de función que realice una operación para obtener una razón.")
	ElseIf $sInterOperacion = "" Then
		MsgBox(16, "Error", "Debes primero conseguir el resultado de " & GUICtrlRead($idInteraccion) & ", para poder obtener la razón de este.")
	Else
		Switch $aInteraccion[1]
			Case "raise"
				$aProceso = _Elevado($aNumbers[1], $aNumbers[2], True)
				$aProceso[0] = StringReplace($aProceso[1], "*", " por ")
				$aProceso[0] = StringReplace($aProceso[1], "=", " igual a ")
				MsgBox(0, "Razón", "La razón de por qué " & $aNumbers[1] & " elevado al " & $sTipoElevacion & " es igual a " & $nResultado & ", es porque " & $aProceso[0])
			Case "root"
				$aProceso = RaizObtenerRazon2($nResultado, $aNumbers[1])
				$aProceso[0] = StringReplace($aProceso[0], "*", " para ")
				MsgBox(0, "Razónn", "El motivo de por qué " & "La raíz " & $sTipoRaiz & " de " & $aNumbers[2] & ", es igual a " & $nResultado & ", se debe a que " & $aProceso[0] & " es igual a: " & $aProceso[1])
				;Vamos a comentar esto, porque trae problemas. EN realidad, la razón para sr está deshabilitada porque está comentada, hasta que encontremos una solución para poder obtener correctamente las razones.
				;case "sr"
				;$aProceso = RaizObtenerRazon2(2, $aNumbers[1])
				;$aProceso[0] = StringReplace($aProceso[0], "*", " para ")
				;Fixes / correcciones:
				;$aProceso[0] &= "/2"
				;$aProceso[1] = $aProceso[1] /2
				;MsgBox(0, "Razón", "Esto es fácil, pero aquí la tienes: " &GuiCtrlRead($idPantallaResultados) &" es porque " &$aProceso[0] &" es igual a " &$aProceso[1])
			Case Else
				MsgBox(16, "Error", "No se puede obtener la razón para " & $aInteraccion[1] & " aquí. Este comando no está soportado como para poder obtener una razón. Si crees que hay una alternativa, por favor dímelo.")
		EndSwitch
	EndIf
EndFunc   ;==>_GetReason