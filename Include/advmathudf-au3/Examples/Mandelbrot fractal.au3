#cs ----------------------------------------------------------------------------

	Example script for Advanced Math UDF
	MANDELBROT FRACTAL

#ce ----------------------------------------------------------------------------

#include "..\Math.au3"
#include <GDIPlus.au3>

$hGUI = GUICreate("Mandelbrot fractal", 400, 400)
GUISetState()

_GDIPlus_Startup()
$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)

For $x = 0 To 200
	For $y = 0 To 200
		$bIsInMandelbrot = Mandelbrot(Point($x/50-2, $y/50-2), 10)
		$iNumIterations = @extended
		$hBrush = _GDIPlus_BrushCreateSolid(BitShift(Int(255*($iNumIterations/10)), -24))
		_GDIPlus_GraphicsFillRect($hGpx, $x*2, $y*2, 2, 2, $hBrush)
		_GDIPlus_BrushDispose($hBrush)
	Next
Next


While 1
	Switch GUIGetMsg()
		Case -3
			ExitLoop
	EndSwitch
WEnd

_GDIPlus_GraphicsDispose($hGpx)
_GDIPlus_Shutdown()
