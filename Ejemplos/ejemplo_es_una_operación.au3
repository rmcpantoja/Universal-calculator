#include "..\include\mymath\misc.au3"
; is this an operation?
local $bIsOperation
local $sOperation = "4+2"
example()
Func example()
$bIsOperation = _is_math_operation($sOperation)
msgbox(0, "", $bIsOperation)
EndFunc