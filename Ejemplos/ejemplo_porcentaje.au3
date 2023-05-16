#include "..\Include\mymath\percent.au3"
; example:
local $aPercentResults
$aPercentResults = _percent(30, 600)
MsgBox(0, "Porcentaje", "30 de 600 es igual al " & $aPercentResults[1] &" porciento.")
$sPercentMessage = _percent_get_reason($aPercentResults)
msgbox(0, "Razón", "Porque " & $sPercentMessage & " es igual a: " & execute($sPercentMessage))
