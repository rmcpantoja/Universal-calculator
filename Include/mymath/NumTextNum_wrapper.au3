#include "..\NumTextNum.au3"

; Wrapper for the amazing NumTextNum library:

; #FUNCTION# ====================================================================================================================
; Name ..........: _NumTextNum_wrapper
; Description ...: Enhances the power of ntn process.
; Syntax ........: _NumTextNum_wrapper($sString[, $sLanguage = "En"])
; Parameters ....: $sString             - Numbers to convert.
;                  $sLanguage           - [optional] the language in a string. Default is "En" (English). The library as also support for spanish by set it as "es".
; Return values .: The converted input
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes, see it in Universal Calculator UI
; ===============================================================================================================================
Func _NumTextNum_wrapper($sString, $sLanguage = "En")
	Local $bIsDecimal
	Local $iLanguageId
	Local $sSeparator
	Switch $sLanguage
		Case "en"
			$iLanguageId = $N2T_LANGENGLISH
			$sSeparator = " point "
		Case "es"
			$iLanguageId = $N2T_LANGSPANISH
			$sSeparator = " punto "
		Case Else
			Return SetError(1, 0, "")
	EndSwitch
	$aMatches = StringRegExp($sString, "(\d+)", 3)
	If @error Then Return SetError(2, 0, "")
	For $i = 0 To UBound($aMatches) - 1
		; Define if is decimal:
		$bIsDecimal = StringInStr($aMatches[$i], ",") Or StringInStr($aMatches[$i], ".")
		If $bIsDecimal Then $sString = StringReplace($sString, ",", ".")
		; Convert:
		$sString = StringReplace($sString, $aMatches[$i], _AutCode_NumberToText($aMatches[$i], $bIsDecimal, "", $sSeparator, $iLanguageId))
	Next
	; Finally:
	Return $sString
EndFunc   ;==>_NumTextNum_wrapper
