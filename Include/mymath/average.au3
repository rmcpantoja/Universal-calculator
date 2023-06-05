; average using an array of numbers:
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _average
; Description ...:
; Syntax ........: _average($aNums)
; Parameters ....: $aNums               - an array of unknowns.
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
func _average($aNums)
	If not IsArray($aNums) then Return SetError(1, 0, "")
	local $sPlus
	for $iNum in $aNums
		if not IsNumber($iNum) then Return SetError(2, 0, "")
		$sPlus &= $iNum & "+"
	Next
	$sPlus = StringTrimRight($sPlus, 1)
	$sPlus = Execute($sPlus)
	return $sPlus / uBound($aNums)
EndFunc