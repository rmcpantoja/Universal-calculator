#include-once

Func IntegralQuadpackQK($n, $xgk, $wg, $wgk, $fv1, $fv2, $fnFunction, $vStart, $vEnd, $aAdditionalParams = 0)
	If IsFunc($fnFunction) Then $fnFunction = FuncName($fnFunction)

	Local $half_length = 0.5*($vEnd-$vStart)
	Local $abs_half_length = Abs($half_length)
	Local $center = 0.5*($vEnd+$vStart)
	Local $f_center = __IntegralCall($fnFunction, $center, $aAdditionalParams)

	Local $result_gauss, $result_kronrod = $f_center*$wgk[$n-1]

	Local $result_abs = Abs($result_kronrod)
	Local $result_asc, $mean, $err

	Local $j

	If Mod($n, 2) = 0 Then
		$result_gauss = $f_center*$wg[$n/2-1]
	EndIf

	For $j = 0 To (($n-1)/2-1)
		Local $jtw = $j*2+1
		Local $abcissa = $half_length*$xgk[$jtw]
		Local $fval1 = __IntegralCall($fnFunction, $center-$abcissa, $aAdditionalParams)
		Local $fval2 = __IntegralCall($fnFunction, $center+$abcissa, $aAdditionalParams)
		Local $fsum = $fval1 + $fval2
		$fv1[$jtw] = $fval1
		$fv2[$jtw] = $fval2
		$result_gauss += $wg[$j]*$fsum
		$result_kronrod += $wgk[$jtw]*$fsum
		$result_abs += $wgk[$jtw]*(Abs($fval1)+Abs($fval2))
	Next

	For $j = 0 To ($n/2-1)
		Local $jtwm1 = $j*2
		Local $abcissa = $half_length*$xgk[$jtwm1]
		Local $fval1 = __IntegralCall($fnFunction, $center-$abcissa, $aAdditionalParams)
		Local $fval2 = __IntegralCall($fnFunction, $center+$abcissa, $aAdditionalParams)
		$fv1[$jtwm1] = $fval1
		$fv2[$jtwm1] = $fval2
		$result_kronrod += $wgk[$jtwm1]*($fval1+$fval2)
		$result_abs += $wgk[$jtwm1]*(Abs($fval1)+Abs($fval2))
	Next

	$mean = $result_kronrod/2
	$result_asc = $wgk[$n-1]*Abs($f_center-$mean)

	For $j = 0 To ($n-2)
		$result_asc += $wgk[$j]*(Abs($fv1[$j]-$mean) + Abs($fv2[$j]-$mean))
	Next

	$result_kronrod *= $half_length

	Return $result_kronrod
EndFunc
