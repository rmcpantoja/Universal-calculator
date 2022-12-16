#include-once

Func RandomCreate($fnFunction, $vPRNGParam1 = Null, $vPRNGParam2 = Null, $vPRNGParam3 = Null, $vPRNGParam4 = Null, $vPRNGParam5 = Null, $vPRNGParam6 = Null, $vPRNGParam7 = Null, $vPRNGParam8 = Null, $vPRNGParam9 = Null, $vPRNGParam10 = Null, $vPRNGParam11 = Null, $vPRNGParam12 = Null)
	If IsFunc($fnFunction) Then $fnFunction = FuncName($fnFunction)

	Local $aPRNGData = [$vPRNGParam1, $vPRNGParam2, $vPRNGParam3, $vPRNGParam4, $vPRNGParam5, $vPRNGParam6, $vPRNGParam7, $vPRNGParam8, $vPRNGParam9, $vPRNGParam10, $vPRNGParam11, $vPRNGParam12]
	Local $fnPRNGFunc = FuncName(Call($fnFunction, $aPRNGData))
	Local $aPRNG = [$fnPRNGFunc, $aPRNGData]

	Return $aPRNG
EndFunc

Func RandomNext(ByRef $aPRNG)
	Return Call($aPRNG[0], $aPRNG[1])
EndFunc
