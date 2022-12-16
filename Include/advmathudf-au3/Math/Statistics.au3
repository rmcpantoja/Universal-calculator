#include-once

Func Variance($aData)
	Local $c = 0, $n = UBound($aData)
	Local $m = ArithmeticMean($aData)

	For $i = 0 To ($n-1)
		$c += ($aData[$i]-$m)^2
	Next

	Return $c/$n
EndFunc

Func SumElements($aData)
	Return ArithmeticMean($aData)*UBound($aData)
EndFunc

Func Covariance($aA, $aB)
	Local $c = 0, $n = UBound($aA)
	Local $mA = ArithmeticMean($aA)
	Local $mB = ArithmeticMean($aB)

	For $i = 0 To ($n-1)
		$c += ($aA[$i]*$mA)*($aB[$i]*$mB)
	Next

	Return $c/$n
EndFunc

Func CentralMoment($aData, $nMoment)
	Local $aTmp = $aData
	Local $m1 = ArithmeticMean($aData)
	Local $c = 0, $n = UBound($aData)

	For $i = 0 To ($n-1)
		$aTmp[$i] = ($aTmp[$i] - $m1)^$nMoment
	Next

	Return ArithmeticMean($aTmp)
EndFunc

Func StandardizedMoment($aData, $nMoment)
	Return CentralMoment($aData, $nMoment)/(StandardDeviation($aData)^$nMoment)
EndFunc

Func StandardDeviation($aData)
	Return Sqrt(Variance($aData))
EndFunc

Func Kurtosis($aData)
	Return CentralMoment($aData, 4)/(StandardDeviation($aData)^4)
EndFunc

Func Skewness($aData)
	Return CentralMoment($aData, 3)/(StandardDeviation($aData)^3)
EndFunc

Func CorrelationPCC($aA, $aB)
	Return Covariance($aA, $aB)/(StandardDeviation($aA)*StandardDeviation($aB))
EndFunc

Func NormalDistributonPDF($x, $m, $s)
	Return (1/($s*Sqrt(2*$Pi)))*Exp((-($x-$m)^2)/(2*$s^2))
EndFunc
