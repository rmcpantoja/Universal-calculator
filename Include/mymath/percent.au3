#include ".\misc.au3" ; for avoit conflicts with native misc.au3.
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _percent
; Description ...: gets the percentage of a minimum and maximum value and the number to get percentage on. (default 100)
; Syntax ........: _percent($iMin, $iMax[, $iToPercent = 100])
; Parameters ....: $iMin                - the minimum value.
;                  $iMax                - the maximum value.
;                  $iToPercent          - [optional] The value to get the percentage. Default is 100.
; Return values .: An array containing: [0] the formula and [1] the result.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
func _percent($iMin, $iMax, $iToPercent=100)
	local $aProgress[2]
	if not isNumber($iMin) or not isNumber($iMax) or not isNumber($iToPercent) then return seterror(1, 0, "")
	; the array can be used for get a reason ([0]) or only get the percent result ([1]).
	$aProgress[0] = $iMin &"/" &$iMax &"*" & $iToPercent
	$aProgress[1] = ($iMin/$iMax)*$iToPercent
	return $aProgress
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _percent_get_reason
; Description ...: gets the reason of a percentage obtained based on the formula created with _percent.
; Syntax ........: _percent_get_reason($aPercentArray)
; Parameters ....: $aPercentArray       - the array that was created with _percent.
; Return values .: A string containing the reason.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
func _percent_get_reason($aPercentArray)
	If Not IsArray($aPercentArray) Or UBound($aPercentArray) <> 2 Then Return SetError(1, 0, "")
	local $aSplittedOperation
	Local $sReason = ""
	$aSplittedOperation = _split_math_operators($aPercentArray[0])
	; result*max/min is eqal to percent (default 100).
	$sReason = number($aPercentArray[1]) & "*" & number($aSplittedOperation[2]) &"/" &number($aSplittedOperation[0])
	Return $sReason
EndFunc