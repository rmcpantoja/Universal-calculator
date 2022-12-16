#cs ----------------------------------------------------------------------------

	Example script for Advanced Math UDF
	GENETIC ALGORITHM

#ce ----------------------------------------------------------------------------

#include "..\Math.au3"
#include <GDIPlus.au3>

; We want to make a line from random points
; First, let's generate a "pool" of random points
Global $aPool[60]
For $i = 0 To 59
	$aPool[$i] = Point(Random(0, 400), Random(0, 400))
Next

; Now, we have to define an error function, which will return how much the point
; is off from the line. It will be called for each point in the pool.
Func _ErrFunc($aPoint)
	Return Abs($aPoint[0]-$aPoint[1])
EndFunc

; Now, we have to define how many points will be classified as "good enough".
; The output amount of points will be larger, because every point will be
; combined with every other! The output amount will be equal to
; 0.5*n*(n+1)
Global $iMaxPassing = 8

$hGUI = GUICreate("Genetic Algorithm", 400, 400)
GUISetState()

_GDIPlus_Startup()
$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

For $Point In $aPool
	_GDIPlus_GraphicsFillEllipse($hGpx, $Point[0]-4, $Point[1]-4, 8, 8)
Next

Global $iIterationNum = 1
While 1
	; Next iteration... They all will end up in one place, so why bother?
	$aPool = GeneticIteration($aPool, _ErrFunc, $iMaxPassing, 100)
	_GDIPlus_GraphicsClear($hGpx, 0xFFFFFFFF)
	_GDIPlus_GraphicsDrawString($hGpx, "Iteration #"&$iIterationNum, 10, 10)
	For $Point In $aPool
		_GDIPlus_GraphicsFillEllipse($hGpx, $Point[0]-4, $Point[1]-4, 8, 8)
	Next
	$iIterationNum += 1
	Sleep(1000)

	Switch GUIGetMsg()
		Case -3
			ExitLoop
	EndSwitch
WEnd

_GDIPlus_GraphicsDispose($hGpx)
_GDIPlus_Shutdown()