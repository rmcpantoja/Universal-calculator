; speaker experiment:
#include <array.au3>
#include <file.au3>
#include "globals.au3"

#include-once

global $sSpeakerDir = @ScriptDir & "\speakers"
global $sSpeakerLanguage = $sSpeakerDir & "\" &$sLang

func _speak_with_speaker($sSpeaker, $sNumber)
local $sDir = $sSpeakerLanguage & "\" &$sSpeaker
SoundPlay($sDir & "\" &$sNumber & ".wav")
if @error then return SetError(1, 0, "")
return True
EndFunc

func _speak_sequence($sSpeaker, $sNumbers, $sSecondDelay)
local $sDir = $sSpeakerLanguage & "\" &$sSpeaker
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