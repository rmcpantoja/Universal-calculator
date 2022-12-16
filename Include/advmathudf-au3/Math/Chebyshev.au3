#include-once

Func _ChebEval($aChebSeries, $fX)
	Local $j, $d = 0, $dd = 0
	Local $y, $y2, $temp

	$y = (2*$fX - $aChebSeries[1] - $aChebSeries[2]) / ($aChebSeries[2] - $aChebSeries[1])
	$y2 = 2*$y

	For $j = (UBound($aChebSeries[0])-1) To 1 Step -1
		$temp = $d
		$d = $y2*$d + ($aChebSeries[0])[$j]
		$dd = $temp
	Next

	Return $y*$d - $dd + 0.5*($aChebSeries[0])[0]
EndFunc