#include-once

Func Sinc($x)
	If $x = 0 Then Return 1
	Return Sin($x)/$x
EndFunc

Func BernoulliStirling($n)
	Return (-1)^($n-1) * 4 * Sqrt($Pi*$n) * ($n/($Pi*$E))^(2*$n)
EndFunc

Func Gd($x)
	Return 2*ATan(Tanh($x/2))
EndFunc

Func AGd($x)
	Return ACosh(Sec($x))
EndFunc

Func GaussLegendrePi($it)
	Local $a = 1, $b = 1/Sqrt(2), $t = 1/4, $p = 1
	Local $a2, $b2, $t2, $p2
	Local $i = 1

	If $it > 1 Then
		Do
			$a2 = ($a+$b)/2
			$b2 = Sqrt($a*$b)
			$t2 = $t-$p*($a-$a2)^2
			$p2 = 2*$p

			$a = $a2
			$b = $b2
			$t = $t2
			$p = $p2

			$i += 1
		Until $i = $it
	EndIf

	Return (($a+$b)^2)/(4*$t)
EndFunc

Func BitEqual($a, $b)
	Return BitNOT(BitXOR($a, $b))
EndFunc

Func AlphaMaxBetaMin($a, $b, $alpha = $M_ALPHA_DEFAULT, $beta = $M_BETA_DEFAULT)
	Return $alpha*_Max($a, $b) + $beta*_Min($a, $b)
EndFunc

Func LevenshteinDistance($sStr1, $sStr2)
	Local $m = StringLen($sStr1), $n = StringLen($sStr2)
	Local $d[$m+1][$n+1], $i

	If $m = 0 Or $n = 0 Then Return _Max($m, $n)

	For $i = 0 To $m
		$d[$i][0] = $i
	Next

	For $i = 0 To $n
		$d[0][$i] = $i
	Next

	For $j = 1 To $n
		For $i = 1 To $m
			If StringMid($sStr1, $i, 1) = StringMid($sStr2, $j, 1) Then
				$d[$i][$j] = $d[$i-1][$j-1]
			Else
				$d[$i][$j] = _Min($d[$i-1][$j]+1, _Min($d[$i][$j-1]+1, $d[$i-1][$j-1]+1))
			EndIf
		Next
	Next

	Return $d[$m][$n]
EndFunc

Func WarpFactor($fVelocity, $iMethod = $M_WARP_REFINED)
	If $iMethod = $M_WARP_ORIGINALSERIES Then Return Cbrt($fVelocity/$SpeedOfLight)
	Return ($fVelocity/$SpeedOfLight)^0.3
EndFunc
