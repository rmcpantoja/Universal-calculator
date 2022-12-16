#cs ----------------------------------------------------------------------------

	Example script for Advanced Math UDF
	FINDING SHORTEST PATH IN A DIRECTED GRAPH

#ce ----------------------------------------------------------------------------


#include "..\Math.au3"

$aGraph = Graph(5)

; Graph indices are 0-based!
GraphAddLink($aGraph, 0, 1, 3)
GraphAddLink($aGraph, 1, 2, 4)
GraphAddLink($aGraph, 2, 0, 6)
GraphAddLink($aGraph, 2, 3, 1)
GraphAddLink($aGraph, 3, 4, 5)
GraphAddLink($aGraph, 4, 1, 7)

; The path is returned as 0-based array of point indices
$aPath = GraphFindPathDijkstra($aGraph, 0, 4, $M_GFP_LESS, True)
_ArrayDisplay($aPath)

ConsoleWrite("Path length: "&GraphGetPathLength($aGraph, $aPath, True)&@CRLF)