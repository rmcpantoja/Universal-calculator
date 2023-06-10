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
$aAverage = _average_get_reason($aNums)
MsgBox(0, "Result", $iAverage)
MsgBox(0, "Whi " &$iAverage & "?", "Because " & $aAverage[0] & ", that is equal to " &execute($aAverage[0]))
MsgBox(0, "And how to make an estimate of all the elements based on the average we got?", $aAverage[1] &" equal to " &execute($aAverage[1]))