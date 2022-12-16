#cs ----------------------------------------------------------------------------

	Example script for Advanced Math UDF
	FINDING SHORTEST PATH IN AN UNDIRECTED GRAPH

#ce ----------------------------------------------------------------------------


#include "..\Math.au3"

$aGraph = Graph(6)

; Graph indices are 0-based!
; Since it does not work with direction,
; $iFrom and $iTo can be swapped with no consequences.
; Links and their weights are taken from https://commons.wikimedia.org/wiki/File:Dijkstra_Animation.gif
GraphAddLink($aGraph, 0, 1, 7)
GraphAddLink($aGraph, 0, 2, 9)
GraphAddLink($aGraph, 0, 5, 14)
GraphAddLink($aGraph, 1, 2, 10)
GraphAddLink($aGraph, 1, 3, 15)
GraphAddLink($aGraph, 2, 5, 2)
GraphAddLink($aGraph, 2, 3, 11)
GraphAddLink($aGraph, 5, 4, 9)
GraphAddLink($aGraph, 3, 4, 6)

; The path is returned as 0-based array of point indices
$aPath = GraphFindPathDijkstra($aGraph, 0, 4)
_ArrayDisplay($aPath)

ConsoleWrite("Path length: "&GraphGetPathLength($aGraph, $aPath)&@CRLF)