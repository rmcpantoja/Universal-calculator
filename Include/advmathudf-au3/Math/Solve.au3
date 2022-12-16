#include-once

Func Solve($fnFunction, $fInitial, $iIterations = 5, $fDelta = 0.001)
	If IsFunc($fnFunction) Then $fnFunction = FuncName($fnFunction)

	Local $fRet = $fInitial
	Local $i

	For $i = 1 To $iIterations
		$fRet = $fRet - (Call($fnFunction, $fRet)/Differential($fnFunction, $fRet, $fDelta))
	Next

	Return $fRet
EndFunc

Func SolveDiff($fnFunction, $fInitial, $iIterations = 5, $fDelta = 0.001)
	If IsFunc($fnFunction) Then $fnFunction = FuncName($fnFunction)

	Local $fRet = $fInitial
	Local $i
	Local $aParams = [$fnFunction, $fDelta]

	For $i = 1 To $iIterations
		$fRet = $fRet - (Differential($fnFunction, $fRet, $fDelta)/Differential(_SolveDiffEq, $fRet, $fDelta, $aParams))
	Next

	Return $fRet
EndFunc

Func _SolveDiffEq($fX, $aParams)
	Return Differential($aParams[0], $fX, $aParams[1])
EndFunc
