#include-once

Func GeneticIteration(ByRef $aPool, $fnError, $iMaxPassing, $iMutationAmount = 0.1, $iMutationProbab = 0.2)
	If IsFunc($fnError) Then $fnError = FuncName($fnError)

	Local $iCount = UBound($aPool)
	Local $aErrors[$iCount][2]
	Local $i, $aItem, $iErr
	Local $iPassItems = _Min($iCount, $iMaxPassing)
	Local $aPassItems[$iPassItems]

	For $i = 0 To ($iCount-1)
		$aItem = $aPool[$i]
		$iErr = Call($fnError, $aItem)

		$aErrors[$i][0] = $aItem
		$aErrors[$i][1] = $iErr
	Next

	_ArraySort($aErrors, 0, 0, 0, 1)

	For $i = 0 To ($iPassItems-1)
		$aItem = $aErrors[$i][0]
		$aPassItems[$i] = $aItem
	Next

	Return GeneticCrossPairs($aPassItems, $iMutationAmount, $iMutationProbab)
EndFunc

Func GeneticCrossPairs($aItems, $iMutationAmount = 0.1, $iMutationProbab = 0.2)
	Local $aOut[0]
	Local $i, $j, $k
	Local $iCount = UBound($aItems)
	Local $aItem1, $aItem2, $iArgCount

	Local $fAmt

	For $i = 0 To ($iCount-1)
		$aItem1 = $aItems[$i]

		For $j = $i to ($iCount-1)
			$aItem2 = $aItems[$j]
			$iArgCount = UBound($aItem1)

			For $k = 0 To ($iArgCount-1)
				$fAmt = Random()

				$aItem1[$k] = LinearInterpolation($fAmt, $aItem1[$k], $aItem2[$k])
				$aItem1[$k] += (Random(0, 1) < $iMutationProbab) ? (Random(-1, 1)*$iMutationAmount) : 0
			Next

			_ArrayAdd($aOut, $aItem1, 0, "|", @CRLF, 1)
		Next
	Next

	Return $aOut
EndFunc