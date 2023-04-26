#include "configs.au3"
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
Func _GetReason($idInter, $sOperation)
	If GUICtrlRead($idInter) = "" Then
		MsgBox(16, translate($sLang, "Error"), translate($sLang, "You must write a function command that performs an operation to get a reason."))
	ElseIf $sOperation = "" Then
		MsgBox(16, translate($sLang, "Error"), translate($sLang, "You must first get the result of") &" " & GUICtrlRead($idInter) & ", " &translate($sLang, "to get the reason for this."))
	ElseIf StringInStr($sOperation, "*") then
		$sProcess = _multi_get_reason($sOperation)
		$sProcess = StringReplace($sProcess, "+", " " &translate($sLang, "plus") &" ")
		MsgBox(0, translate($sLang, "Reason"), translate($sLang, "The reason why") &" " & $sOperation & " " &translate($sLang, "is equal to") &" " & $nResult &", " & translate($sLang, "it is because") &" " & $sProcess &" " &translate($sLang, "is equal to") &" " &execute($sProcess) &". " &translate($sLang, "This is a very easy way to know the reason of a multiplication; however, for a better experience, you can guide yourself through multiplying tables."))
	ElseIf StringInStr($sOperation, "/") then
		$sProcess = _div_get_reason($sOperation, $nResult)
		MsgBox(0, translate($sLang, "Reason"), translate($sLang, "A basic way to know why") &" " & $sOperation & " " &translate($sLang, "is equal to") &" " & $nResult & ", " &translate($sLang, "it is because") &" " & $sProcess &" " &translate($sLang, "is equal to") &" " &round(execute($sProcess)))
	Else
		Switch $aSplitCMD[1]
			Case "raise"
				$aProcess = _Elevado($aNumbers[1], $aNumbers[2], True)
				$aProcess[0] = StringReplace($aProcess[1], "*", " " &translate($sLang, "multiplied by") &" ")
				$aProcess[0] = StringReplace($aProcess[1], "=", " " &translate($sLang, "equal to") &" ")
				MsgBox(0, translate($sLang, "Reason"), translate($sLang, "The reason why") &" " & $aNumbers[1] & " " &translate($sLang, "raised to") &" " & $sRaiseType & " " &translate($sLang, "is equal to") &" " & $nResult & ", " &translate($sLang, "it is because") &" " & $aProcess[0])
			Case "root"
				$aProcess = RaizObtenerRazon2($nResult, $aNumbers[1])
				$aProcess[0] = StringReplace($aProcess[0], "*", " " &translate($sLang, "multiplied by") &" ")
				MsgBox(0, translate($sLang, "Reason"), translate($sLang, "The reason why the root") &" " & $sRootType & " " &translate($sLang, "of") &" " & $aNumbers[2] & ", " &translate($sLang, "is equal to") &" " & $nResult & ", " &translate($sLang, "it is because") &" " & $aProcess[0] & " " &translate($sLang, "is equal to") &" " & $aProcess[1])
				;Vamos a comentar esto, porque trae problemas. EN realidad, la razón para sr está deshabilitada porque está comentada, hasta que encontremos una solución para poder obtener correctamente las razones.
				;case "sr"
				;$aProcess = RaizObtenerRazon2(2, $aNumbers[1])
				;$aProcess[0] = StringReplace($aProcess[0], "*", " para ")
				;Fixes / correcciones:
				;$aProcess[0] &= "/2"
				;$aProcess[1] = $aProcess[1] /2
				;MsgBox(0, "Razón", "Esto es fácil, pero aquí la tienes: " &GuiCtrlRead($idPantallaResultados) &" es porque " &$aProcess[0] &" es igual a " &$aProcess[1])
			Case Else
				MsgBox(16, translate($sLang, "Error"), translate($sLang, "Can't get the reason for") &" " & $aSplitCMD[1] & " " &Translate($sLang, "here. This command is not supported enough to get a reason. If you think there is an alternative, please tell me."))
		EndSwitch
	EndIf
EndFunc   ;==>_GetReason