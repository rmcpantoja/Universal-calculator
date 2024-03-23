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
	;ConsoleWrite(number($sOperation) &@CRLF)
	If GUICtrlRead($idInter) = "" Then
		MsgBox(16, translate($sLang, "Error"), translate($sLang, "You must write a function command that performs an operation to get a reason."))
	ElseIf $sOperation = "" Then
		MsgBox( _
				16, _
				translate($sLang, "Error"), _
				translate($sLang, "You must first get the result of") & " " & GUICtrlRead($idInter) & ", " & translate($sLang, "to get the reason for this.") _
				)
	ElseIf StringLen($sOperation) > 308 Then
		; Reason for infinity number (inf):
		MsgBox(0, "Reason", 'The "inf" means an infinity number. The calculator reaches up to e+308 numbers.')
	ElseIf StringInStr($sOperation, "*") Then
		$sProcess = _multi_get_reason($sOperation)
		$sProcessResult = Execute($sProcess)
		$sProcess = StringReplace($sProcess, "+", " " & translate($sLang, "plus") & " ")
		MsgBox( _
				0, _
				translate($sLang, "Reason"), _
				translate($sLang, "The reason why") & " " & $sOperation & " " & translate($sLang, "is equal to") & " " & $nResult & ", " & translate($sLang, "it is because") & " " & $sProcess & " " & translate($sLang, "is equal to") & " " & Execute($sProcessResult) & ". " & translate($sLang, "This is a very easy way to know the reason of a multiplication; however, for a better experience, you can guide yourself through multiplying tables.") _
				)
	ElseIf StringInStr($sOperation, "/") Then
		$sProcess = _div_get_reason($sOperation, $nResult)
		MsgBox( _
				0, _
				translate($sLang, "Reason"), _
				translate($sLang, "A basic way to know why") & " " & $sOperation & " " & translate($sLang, "is equal to") & " " & $nResult & ", " & translate($sLang, "it is because") & " " & $sProcess & " " & translate($sLang, "is equal to") & " " & Round(Execute($sProcess)) _
				)
	Else
		Switch $aSplitCMD[1]
			Case "raise"
				$aProcess = _Elevado($aNumbers[1], $aNumbers[2], True)
				$aProcess[0] = StringReplace($aProcess[1], "*", " " & translate($sLang, "multiplied by") & " ")
				$aProcess[0] = StringReplace($aProcess[1], "=", " " & translate($sLang, "equal to") & " ")
				MsgBox( _
						0, _
						translate($sLang, "Reason"), _
						translate($sLang, "The reason why") & " " & $aNumbers[1] & " " & translate($sLang, "raised to") & " " & $sRaiseType & " " & translate($sLang, "is equal to") & " " & $nResult & ", " & translate($sLang, "it is because") & " " & $aProcess[0] _
				)
			Case "root"
				$aProcess = RaizObtenerRazon2($nResult, $aNumbers[1])
				$aProcess[0] = StringReplace($aProcess[0], "*", " " & translate($sLang, "multiplied by") & " ")
				MsgBox( _
						0, _
						translate($sLang, "Reason"), _
						translate($sLang, "The reason why the root") & " " & $sRootType & " " & translate($sLang, "of") & " " & $aNumbers[2] & ", " & translate($sLang, "is equal to") & " " & $nResult & ", " & translate($sLang, "it is because") & " " & $aProcess[0] & " " & translate($sLang, "is equal to") & " " & $aProcess[1])
			Case "per"
				$sProcess = _percent_get_reason($aPercentArray)
				MsgBox( _
						0, _
						translate($sLang, "Reason"), _
						translate($sLang, "The reason why") & " " & $apercentArray[0] & " " & translate($sLang, "is equal to") & " " & $nResult & ", " & translate($sLang, "it is because") & " " & $sProcess & " " & translate($sLang, "is equal to") & " " & Execute($sProcess) _
						)
			Case "av"
				$aProcess = _average_get_reason($aNumbers)
				MsgBox( _
						0, _
						translate($sLang, "Reasons"), _
						translate($sLang, "It is possible to know the reason why the average of all these numbers is equal to") & " " & $nResult & translate($sLang, "As follows:") & @CRLF & "1. " & $aProcess[0] & "=" & Execute($aProcess[0]) & "." & @CRLF & "2. " & $aProcess[1] & "=" & Execute($aProcess[1]) & "." _
				)
				;case "sr"
				;$aProcess = RaizObtenerRazon2(2, $aNumbers[1])
				;$aProcess[0] = StringReplace($aProcess[0], "*", " para ")
				;Fixes / correcciones:
				;$aProcess[0] &= "/2"
				;$aProcess[1] = $aProcess[1] /2
				;MsgBox(0, "Razón", "Esto es fácil, pero aquí la tienes: " &GuiCtrlRead($idPantallaResultados) &" es porque " &$aProcess[0] &" es igual a " &$aProcess[1])
			Case Else
				MsgBox( _
						16, _
						translate($sLang, "Error"), _
						translate($sLang, "Can't get the reason for") & " " & $aSplitCMD[1] & " " & Translate($sLang, "here. This command is not supported enough to get a reason. If you think there is an alternative, please tell me.") _
						)
		EndSwitch
	EndIf
EndFunc   ;==>_GetReason
