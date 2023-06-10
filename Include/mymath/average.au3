; average using an array of numbers:
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _average
; Description ...: Gets the average of an array of multiple numbers.
; Syntax ........: _average($aNums[, $bReason = False])
; Parameters ....: $aNums               - A 1d array containing numbers.
;                  $bReason             - [optional] a boolean value to return the operation process instead of the average result. Default is False.
; Return values .: If $bReason is true, return the operation process, otherwise the average of these elements.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
func _average($aNums, $bReason = False)
	If not IsArray($aNums) then Return SetError(1, 0, "")
	if uBound($aNums) <= 1 then Return SetError(2, 0, "")
	local $sPlus
	for $iNum in $aNums
		if not IsNumber($iNum) then Return SetError(3, 0, "")
		$sPlus &= $iNum & "+"
	Next
	$sPlus = StringTrimRight($sPlus, 1)
	if $bReason then
		return "(" & $sPlus & ")/" & uBound($aNums)
	Else
		$sPlus = Execute($sPlus)
		return $sPlus / uBound($aNums)
	EndIf
EndFunc
; #FUNCTION# ====================================================================================================================
; Name ..........: _average_get_reason
; Description ...: gets the reason of an average
; Syntax ........: _average_get_reason($aNums)
; Parameters ....: $aNums               - the 1d array with which the average was got.
; Return values .: An array. $aArray[0] the formula of the average with the elements of the array, $aArray[1] an approximation of the sum of all the elements.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
func _average_get_reason($aNums)
	Local $aReasons[]
	local $sOperation
	If not IsArray($aNums) then Return SetError(1, 0, "")
	if uBound($aNums) <= 1 then Return SetError(2, 0, "")
	$sOperation = _average($aNums, True)
	$aReasons[0] = $sOperation
	; reason2: Reason 2 is an approximate of the sum of all the elements. I repeat, it's an approximation
	$sOperation = _average($aNums) & "*" & uBound($aNums)
	$aReasons[1] = $sOperation
	return $aReasons
EndFunc