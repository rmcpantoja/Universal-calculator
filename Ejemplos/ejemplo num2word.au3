#include "..\include\mymath\num2words.au3"
$nNumber = 25432
$bIncludeAnd = False
MsgBox($MB_SYSTEMMODAL, "Numbers to words conversion", NumberToWords($nNumber, $bIncludeAnd))