#include-once

Func GraphFindPathDijkstra(ByRef $aGraph, $iStart, $iEnd, $iMode = $M_GFP_LESS, $bForceDirection = False)
	Local $aPath[1] = [$iStart]
	Local $aConns, $aConn
	Local $iCurrent = $iStart, $iNewCurrent
	Local $nMin, $i, $nCLen
	Local $iPrev = -1, $nProbablePreviousPathLength
	Local $nPathLength1 = 0, $nPathLength2 = 0

	GraphMarkAll($aGraph, 0)

	Do
		$aConns = GraphGetConnections($aGraph, $iCurrent, $bForceDirection)
		$nMin = Number(0xFFFFFF)
		For $i = 0 To (UBound($aConns)-1)
			If GraphGetMark($aGraph, $aConns[$i][0]) Then ContinueLoop
			If $iCurrent = $aConns[$i][0] Then ContinueLoop
			$nCLen = Number($aConns[$i][1])
			If ($iMode = $M_GFP_LESS And $nCLen < $nMin) Or ($iMode = $M_GFP_LESSOREQUAL And $nCLen <= $nMin) Or $aConns[$i][0] = $iEnd Then
				$nMin = Number($aConns[$i][1])
				$iNewCurrent = $aConns[$i][0]
			EndIf
		Next

		$nPathLength1 = $nPathLength2
		$nPathLength2 = $nMin

		If $iPrev <> -1 Then
			$nPreviousPathLength = GraphIsConnected($aGraph, $iPrev, $iNewCurrent, $bForceDirection)
			If $nPreviousPathLength <= ($nPathLength1+$nPathLength2) And $nPreviousPathLength <> -1 Then
				$iCurrent = $iPrev
				_ArrayPop($aPath)
			EndIf
		EndIf
		GraphMarkPoint($aGraph, $iCurrent, 1)
		$iPrev = $iCurrent
		$iCurrent = $iNewCurrent
		_ArrayAdd($aPath, $iCurrent)
	Until $iCurrent = $iEnd

	GraphMarkAll($aGraph, 0)

	Return $aPath
EndFunc