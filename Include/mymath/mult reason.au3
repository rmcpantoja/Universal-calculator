#include <StringConstants.au3>
; obtener razón de una multiplicación
; #FUNCTION# ====================================================================================================================
; Name ..........: _multi_get_reason
; Description ...:
; Syntax ........: _multi_get_reason($sMult)
; Parameters ....: $sMult               - a string value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _multi_get_reason($sMult)
	; declare:
	Local $aValues
	Local $sResult = ""
	; UDF checks:
	If Not IsString($sMult) Then Return SetError(1, 0, "")
	If Not StringInStr($sMult, "*") Then Return SetError(2, 0, "")
	; strip spaces:
	If StringInStr($sMult, " ") Then $sMult = StringStripWS($sMult, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
	; split mult:
	$aValues = StringSplit($sMult, "*")
	; the basic wai to get a reason is (multiplying number+x+x...) the number of repeats is the multiplier.
	For $I = 1 To $aValues[2] - 1
		$sResult &= $aValues[1] & "+"
	Next
	$sResult &= $aValues[1]
	; finally returns the reason:
	Return $sResult
EndFunc   ;==>_multi_get_reason
