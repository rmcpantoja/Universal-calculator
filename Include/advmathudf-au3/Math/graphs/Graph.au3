#include-once

Func Graph($nPoints = 0)
	Local $aRet[2]
	Local $aPoints[$nPoints], $aLinks[0]
	$aRet[0] = $aPoints
	$aRet[1] = $aLinks
	Return $aRet
EndFunc

Func GraphAddPoint(ByRef $aGraph)
	_ArrayAdd($aGraph[0], 0)
	Return UBound($aGraph[0])-1
EndFunc

Func GraphAddLink(ByRef $aGraph, $iFrom, $iTo, $nLinkWeight = 1)
	Local $aLink = [$iFrom, $iTo, $nLinkWeight]
	_ArrayAdd($aGraph[1], $aLink, 0, "|", @CRLF, $ARRAYFILL_FORCE_SINGLEITEM)
	Return UBound($aGraph[1])-1
EndFunc

Func GraphMarkPoint(ByRef $aGraph, $iPoint, $iMark)
	Local $aPoints = $aGraph[0]
	Local $tMark = $aPoints[$iPoint]
	$aPoints[$iPoint] = $iMark
	$aGraph[0] = $aPoints
	Return $tMark
EndFunc

Func GraphGetMark(ByRef $aGraph, $iPoint)
	Local $aPoints = $aGraph[0]
	Return $aPoints[$iPoint]
EndFunc

Func GraphMarkAll(ByRef $aGraph, $iMark)
	Local $i = 0
	For $i = 0 To (UBound($aGraph[0])-1)
		$aGraph[0][$i] = $iMark
	Next
	Return 0
EndFunc

Func GraphGetConnections(ByRef $aGraph, $iFrom, $bForceDirection = False)
	Local $aRet[0][2]
	Local $iOther

	For $aLink In $aGraph[1]
		If $bForceDirection And $iFrom = $aLink[0] Then
			_ArrayAdd($aRet, $aLink[1]&"|"&$aLink[2])
		ElseIf Not $bForceDirection And ($iFrom = $aLink[0] Or $iFrom = $aLink[1]) Then
			$iOther = ($iFrom = $aLink[0]) ? $aLink[1] : $aLink[0]
			_ArrayAdd($aRet, $iOther&"|"&$aLink[2])
		EndIf
	Next

	Return $aRet
EndFunc

Func GraphIsConnected(ByRef $aGraph, $iFrom, $iTo, $bForceDirection = False)
	Local $iOther

	For $aLink In $aGraph[1]
		If $bForceDirection And $iFrom = $aLink[0] Then
			If $aLink[1] = $iTo Then Return $aLink[2]
		ElseIf Not $bForceDirection And ($iFrom = $aLink[0] Or $iFrom = $aLink[1]) Then
			$iOther = ($iFrom = $aLink[0]) ? $aLink[1] : $aLink[0]
			If $iOther = $iTo Then Return $aLink[2]
		EndIf
	Next

	Return -1
EndFunc

Func GraphGetPathLength(ByRef $aGraph, ByRef $aPath, $bForceDirection = False)
	Local $nRet = 0
	Local $i = 0

	For $i = 0 To (UBound($aPath)-2)
		For $aLink In $aGraph[1]
			If ($bForceDirection = False And (($aLink[0] = $aPath[$i] And $aLink[1] = $aPath[$i+1]) Or ($aLink[1] = $aPath[$i] And $aLink[0] = $aPath[$i+1]))) Or ($aLink[0] = $aPath[$i] And $aLink[1] = $aPath[$i+1]) Then
				$nRet += $aLink[2]
			EndIf
		Next
	Next

	Return $nRet
EndFunc

