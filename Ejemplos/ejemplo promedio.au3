local $aNums = [ _
	13, _
	11, _
	9, _
	15, _
	12, _
	14 _
]
$iAverage = _average($aNums )
MsgBox(0, "", $iAverage)
func _average($aNums)
	If not IsArray($aNums) then Return SetError(1, 0, "")
	local $sPlus
	for $iNum in $aNums
		$sPlus &= $iNum & "+"
	Next
	$sPlus = StringTrimRight($sPlus, 1)
	$sPlus = Execute($sPlus)
	return $sPlus / uBound($aNums)
EndFunc