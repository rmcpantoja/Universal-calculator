; speaker experiment:
#include <array.au3>
#include <file.au3>
#include "globals.au3"

#include-once

global $sSpeakerDir = @ScriptDir & "\speakers"

; #FUNCTION# ====================================================================================================================
; Name ..........: _speak_with_speaker
; Description ...:
; Syntax ........: _speak_with_speaker($sLanguage, $sSpeaker, $sNumber)
; Parameters ....: $sLanguage           - a string value.
;                  $sSpeaker            - a string value.
;                  $sNumber             - a string value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
func _speak_with_speaker($sLanguage, $sSpeaker, $sNumber)
local $sDir = $sSpeakerDir & "\" & $sLanguage & "\" & $sSpeaker
if not FileExists($sDir) then Return SetError(1, 0, "")
switch $sNumber
case "*"
$sNumber = "mult"
case "/"
$sNumber = "div"
EndSwitch

SoundPlay($sDir & "\" &$sNumber & ".wav")
if @error then return SetError(2, 0, "")
return True
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _speak_sequence
; Description ...:
; Syntax ........: _speak_sequence($sLanguage, $sSpeaker, $sNumbers, $sSecondDelay)
; Parameters ....: $sLanguage           - a string value.
;                  $sSpeaker            - a string value.
;                  $sNumbers            - a string value.
;                  $sSecondDelay        - a string value.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
func _speak_sequence($sLanguage, $sSpeaker, $sNumbers, $sSecondDelay)
local $sDir = $sSpeakerDir & "\" & $sLanguage & "\" & $sSpeaker
if not FileExists($sDir) then Return SetError(1, 0, "")
local $sDelay = $sSecondDelay * 1000
for $I = 1 to StringLen($sNumbers)
$sNumber = StringMid($sNumbers, $I, 1)
switch $sNumber
case "*"
$sNumber = "mult"
case "/"
$sNumber = "div"
EndSwitch
SoundPlay($sDir & "\" & $sNumber & ".wav")
if @error then return SetError(1, 0, "")
sleep($sDelay)
next
return True
EndFunc