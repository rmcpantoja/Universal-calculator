#include-once

; Using Lanczos approximation
; Converted from Python code (source: https://en.wikipedia.org/wiki/Lanczos_approximation)
Func Gamma($x)
	Local $p = [676.5203681218851, -1259.1392167224028,  771.32342877765313, -176.61502916214059, 12.507343278686905, -0.13857109526572012, 9.9843695780195716e-6, 1.5056327351493116e-7], $t, $i, $q

	If $x < 0.5 Then
		Return $Pi / (Sin($Pi*$x)*Gamma2(1-$x))
	Else
		$x -= 1
		$t = 0.99999999999980993

		For $i = 0 To (UBound($p)-1)
			$t += $p[$i]/($x+$i+1)
		Next

		$q = $x + UBound($p) - 0.5

		Return Sqrt(2*$Pi) * $q^($x+0.5) * Exp(-$q) * $t
	EndIf
EndFunc

Func IncompleteGamma($a, $x)
	Local $aParams = [$a]
	Return (1/Gamma($a))*Integral(_InclGammaInt, 0, $x, 0.001, $aParams)
EndFunc

Func Digamma($x)
	Return Differential(Gamma, $x)/Gamma($x)
EndFunc

Func Trigamma($x)
	Return HurwitzZeta(2, $x)
EndFunc

Func Beta($x, $y)
	Return (Gamma($x)*Gamma($y))/Gamma($x*$y)
EndFunc

Func _InclGammaInt($x, $aParams)
	Return Exp(-$x)*($x^($aParams[0]-1))
EndFunc