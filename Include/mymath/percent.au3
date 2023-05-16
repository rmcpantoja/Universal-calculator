#include ".\misc.au3" ; for avoit conflicts with native misc.au3.

func _percent($iMin, $iMax, $iToPercent=100)
	local $aProgress[2]
	if not isNumber($iMin) or not isNumber($iMax) or not isNumber($iToPercent) then return seterror(1, 0, "")
	; the array can be used for get a reason ([0]) or only get the percent result ([1]).
	$aProgress[0] = $iMin &"/" &$iMax &"*" & $iToPercent
	$aProgress[1] = ($iMin/$iMax)*$iToPercent
	return $aProgress
EndFunc
func _percent_get_reason($aPercentArray)
	If Not IsArray($aPercentArray) Or UBound($aPercentArray) <> 2 Then Return SetError(1, 0, "")
	local $aSplittedOperation
	Local $sReason = ""
	$aSplittedOperation = _split_math_operators($aPercentArray[0])
	; result*max/min is eqal to percent (default 100).
	$sReason = number($aPercentArray[1]) & "*" & number($aSplittedOperation[2]) &"/" &number($aSplittedOperation[0])
	Return $sReason
EndFunc