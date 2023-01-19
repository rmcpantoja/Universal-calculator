#include "globals.au3"
#include "..\mymath\basic reason.au3"
#include "..\mymath\elevar.au3"
#include "..\mymath\raiz.au3"
#include "..\translator.au3"
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _GetReason
; Description ...: function to get the reason for an operation.
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
	If GUICtrlRead($idInter) = "" Then
		MsgBox(16, "Error", "Debes escribir un comando de función que realice una operación para obtener una razón.")
	ElseIf $sOperation = "" Then
		MsgBox(16, "Error", "Debes primero conseguir el resultado de " & GUICtrlRead($idInter) & ", para poder obtener la razón de este.")
	ElseIf StringInStr($sOperation, "*") then
		$sProcess = _multi_get_reason($sOperation)
		$sProcess = StringReplace($sProcess, "+", " más ")
		MsgBox(0, "Razón", "La razón de por qué " & $sOperation & " es igual a " & $nResult & ", es porque " & $sProcess &" es igual a " &execute($sProcess) &". Esta es una forma muy fácil de saber la razón de una multiplicación; sin embargo, para una mejor experiencia, puedes guiarte a través de tablas.")
	ElseIf StringInStr($sOperation, "/") then
		$sProcess = _div_get_reason($sOperation, $nResult)
		MsgBox(0, "Razón", "Una forma básica de saber por qué " & $sOperation & " es igual a " & $nResult & ", es porque " & $sProcess &" es igual a " &round(execute($sProcess)))
	Else
		Switch $aSplitCMD[1]
			Case "raise"
				$aProcess = _Elevado($aNumbers[1], $aNumbers[2], True)
				$aProcess[0] = StringReplace($aProcess[1], "*", " por ")
				$aProcess[0] = StringReplace($aProcess[1], "=", " igual a ")
				MsgBox(0, "Razón", "La razón de por qué " & $aNumbers[1] & " elevado al " & $sRaiseType & " es igual a " & $nResult & ", es porque " & $aProcess[0])
			Case "root"
				$aProcess = RaizObtenerRazon2($nResult, $aNumbers[1])
				$aProcess[0] = StringReplace($aProcess[0], "*", " para ")
				MsgBox(0, "Razónn", "El motivo de por qué la raíz " & $sRootType & " de " & $aNumbers[2] & ", es igual a " & $nResult & ", se debe a que " & $aProcess[0] & " es igual a: " & $aProcess[1])
				;Vamos a comentar esto, porque trae problemas. EN realidad, la razón para sr está deshabilitada porque está comentada, hasta que encontremos una solución para poder obtener correctamente las razones.
				;case "sr"
				;$aProcess = RaizObtenerRazon2(2, $aNumbers[1])
				;$aProcess[0] = StringReplace($aProcess[0], "*", " para ")
				;Fixes / correcciones:
				;$aProcess[0] &= "/2"
				;$aProcess[1] = $aProcess[1] /2
				;MsgBox(0, "Razón", "Esto es fácil, pero aquí la tienes: " &GuiCtrlRead($idPantallaResultados) &" es porque " &$aProcess[0] &" es igual a " &$aProcess[1])
			Case Else
				MsgBox(16, "Error", "No se puede obtener la razón para " & $aSplitCMD[1] & " aquí. Este comando no está soportado como para poder obtener una razón. Si crees que hay una alternativa, por favor dímelo.")
		EndSwitch
	EndIf
EndFunc   ;==>_GetReason