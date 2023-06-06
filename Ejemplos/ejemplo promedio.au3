#include "..\include\mymath\average.au3"
local $aNums = [ _
	13, _
	11, _
	9, _
	15, _
	12, _
	14 _
]
$iAverage = _average($aNums)
MsgBox(0, "", $iAverage)
; error debugging:
ReDim $aNums[0]
$iAverage = _average($aNums)
if @error then
MsgBox(0, "error in averaging", "Code: " & @error)
EndIf