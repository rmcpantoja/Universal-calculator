#include-once

Func Mandelbrot($aPoint, $iIterations)
	Local $iIter = 0
	Local $aComplex = Complex(0, 0)

	Do
		$aComplex = ComplexAdd(ComplexMultiply($aComplex, $aComplex), $aPoint)
		$iIter += 1
	Until $iIter >= $iIterations Or ComplexAbs($aComplex) > 2

	Return SetExtended($iIter, ComplexAbs($aComplex) < 2)
EndFunc