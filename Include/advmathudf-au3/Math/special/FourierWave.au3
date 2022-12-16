#include-once

Func FourierSquareWave($t, $f, $it = 5)
	Local $sum = 0

	For $k = 1 To $it
		$sum += (Sin(2*$Pi*(2*$k-1)*$f*$t))/(2*$k-1)
	Next

	Return $sum*(4/$Pi)
EndFunc

Func FourierSawtoothWave($t, $f, $it = 5)
	Local $sum = 0

	For $k = 1 To $it
		$sum += (Sin(2*$Pi*$k*$f*$t))/$k
	Next

	Return 1 - (2/$Pi)*$sum
EndFunc

Func FourierTriangleWave($t, $f, $it = 5)
	Local $sum = 0

	For $k = 1 To $it
		$sum += ((-1)^$k)*(Sin(2*$Pi*$f*$t*(2*$k+1))/((2*$k+1)^2))
	Next

	Return (8/$Pi^2)*$sum
EndFunc