; speaker experiment:
#include <array.au3>
#include <file.au3>
#include "globals.au3"

#include-once

Global $sSpeakerDir = @ScriptDir & "\speakers"

; #FUNCTION# ====================================================================================================================
; Name ..........: _speak_with_speaker
; Description ...: Speaks a number with a voice
; Syntax ........: _speak_with_speaker($sLanguage, $sSpeaker, $sNumber)
; Parameters ....: $sLanguage           - The language of the voice.
;                  $sSpeaker            - A speaker name.
;                  $sNumber             - Number or symbol to speak.
; Return values .: True if all is correct. Otherwise, @error = 1 if the speaker diesn't exists or @error = 2, failed to play.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _speak_with_speaker($sLanguage, $sSpeaker, $sNumber)
	Local $sDir = $sSpeakerDir & "\" & $sLanguage & "\" & $sSpeaker
	If Not FileExists($sDir) Then Return SetError(1, 0, "")
	Switch $sNumber
		Case "*"
			$sNumber = "mult"
		Case "/"
			$sNumber = "div"
	EndSwitch
	SoundPlay($sDir & "\" & $sNumber & ".wav")
	If @error Then Return SetError(2, 0, "")
	Return True
EndFunc   ;==>_speak_with_speaker

; #FUNCTION# ====================================================================================================================
; Name ..........: _speak_sequence
; Description ...: Speaks more than one number, one by one.
; Syntax ........: _speak_sequence($sLanguage, $sSpeaker, $sNumbers, $sSecondDelay)
; Parameters ....: $sLanguage           - The language of the voice.
;                  $sSpeaker            - A speaker name.
;                  $sNumbers            - A set of numbers.
;                  $sSecondDelay        - How often will you say each number.
; Return values .: True if all is correct. Otherwise, @error = 1 if the speaker diesn't exists or @error = 2, failed to play.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _speak_sequence($sLanguage, $sSpeaker, $sNumbers, $sSecondDelay)
	Local $sDir = $sSpeakerDir & "\" & $sLanguage & "\" & $sSpeaker
	If Not FileExists($sDir) Then Return SetError(1, 0, "")
	Local $sDelay = $sSecondDelay * 1000
	For $I = 1 To StringLen($sNumbers)
		$sNumber = StringMid($sNumbers, $I, 1)
		Switch $sNumber
			Case "*"
				$sNumber = "mult"
			Case "/"
				$sNumber = "div"
		EndSwitch
		SoundPlay($sDir & "\" & $sNumber & ".wav")
		If @error Then Return SetError(1, 0, "")
		Sleep($sDelay)
	Next
	Return True
EndFunc   ;==>_speak_sequence
