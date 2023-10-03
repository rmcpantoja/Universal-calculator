#include "include\calculator\speaker.au3"
$sTitle = "Speaker test"
MsgBox(0, $sTitle, "Say 1.")
_speak_with_speaker("f1", "1")
if @error then exit
MsgBox(0, $sTitle, "Sayinng 3580 by number")
_speak_sequence("f1", "3580", 0.5)
if @error then exit
MsgBox(0, $sTitle, "Done! All tests passed.")