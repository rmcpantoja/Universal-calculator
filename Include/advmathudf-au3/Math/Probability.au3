#include-once

Func CoinFlip()
	Local $aRet = ["H", "T"]

	Return $aRet
EndFunc

Func DieRoll()
	Local $aRet = [1, 2, 3, 4, 5, 6]

	Return $aRet
EndFunc

Func CalculateProbability($aEvents, $aExpectedResults, $bReturnAll = False, $iSampleCount = 10)
	Local $i, $j, $n, $Event, $aOccurences
	Local $EventValue
	Local $aRet[UBound($aExpectedResults)]

	For $i = 0 To (UBound($aEvents)-1)
		$Event = $aEvents[$i]
		$n = 0

		If IsArray($Event) Then
			For $j = 0 To (UBound($Event)-1)
				If IsArray($aExpectedResults[$i]) Then
					$aOccurences = _ArrayFindAll($aExpectedResults[$i], $Event[$j])

					If IsArray($aOccurences) Then $n += UBound($aOccurences)
				Else
					If $Event[$j] = $aExpectedResults[$i] Then $n += 1
				EndIf
			Next
			$n /= UBound($Event)
		Else
			If IsFunc($Event) Then $Event = FuncName($Event)

			For $j = 1 To $iSampleCount
				$EventValue = Call($Event)
				If IsArray($aExpectedResults[$i]) Then
					$aOccurences = _ArrayFindAll($aExpectedResults[$i], $EventValue)

					If IsArray($aOccurences) Then $n += UBound($aOccurences)
				Else
					If $EventValue = $aExpectedResults[$i] Then $n += 1
				EndIf
			Next
			$n /= $iSampleCount
		EndIf

		$aRet[$i] = $n
	Next

	If $bReturnAll Then Return $aRet

	Local $fRet = 1

	For $i = 0 To (UBound($aRet)-1)
		$fRet *= $aRet[$i]
	Next

	Return $fRet
EndFunc

Func NormalDistribution($x, $m, $s2)
	Local $s = Sqrt($s2)

	Return 1/($s*Sqrt(2*$Pi))*Exp(-(($x-$m)^2)/(2*$s2))
EndFunc

Func ArcsineDistribution($x)
	Return 1/($Pi*Sqrt($x*(1-$x)))
EndFunc

Func BetaDistribution($x, $a, $b)
	Return (($x^($a-1))*(1-$x)^($b-1))/Beta($a, $b)
EndFunc


Func DiracDelta($x, $a)
	Return (1/($a*Sqrt($Pi)))*Exp(-$x^2/$a^2)
EndFunc
