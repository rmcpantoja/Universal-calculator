#cs ----------------------------------------------------------------------------

	Example script for Advanced Math UDF
	MOLLIFY

#ce ----------------------------------------------------------------------------

#include "../Math.au3"
#include <GDIPlus.au3>

$hGUI = GUICreate("Smoothing a square wave", 400, 205)
GUISetState()

_GDIPlus_Startup()
$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)
_GDIPlus_GraphicsSetSmoothingMode($hGpx, 2)

For $x = 0 To 399
	$val = Mollify(Sq, $x/50 - 4, SharpMollifier, 0.2)*100 + 102
	$val2 = Mollify(Sq, ($x-1)/50 - 4, SharpMollifier, 0.2)*100 + 102
	_GDIPlus_GraphicsDrawLine($hGpx, $x, $val, $x-1, $val2)
Next

For $x = 0 To 399
	$val = Mollify(Sq, $x/50 - 4, SharpMollifier, 0.5)*100 + 102
	$val2 = Mollify(Sq, ($x-1)/50 - 4, SharpMollifier, 0.5)*100 + 102
	_GDIPlus_GraphicsDrawLine($hGpx, $x, $val, $x-1, $val2)
Next

For $x = 0 To 399
	$val = Mollify(Sq, $x/50 - 4, SharpMollifier)*100 + 102
	$val2 = Mollify(Sq, ($x-1)/50 - 4, SharpMollifier)*100 + 102
	_GDIPlus_GraphicsDrawLine($hGpx, $x, $val, $x-1, $val2)
Next

For $x = 0 To 399
	$val = Mollify(Sq, $x/50 - 4, SharpMollifier, 2)*100 + 102
	$val2 = Mollify(Sq, ($x-1)/50 - 4, SharpMollifier, 2)*100 + 102
	_GDIPlus_GraphicsDrawLine($hGpx, $x, $val, $x-1, $val2)
Next

While 1
	Switch GUIGetMsg()
		Case -3
			ExitLoop
	EndSwitch
WEnd

_GDIPlus_GraphicsDispose($hGpx)
_GDIPlus_Shutdown()

Func Sq($x)
	Return SquareWave($x, 3)
EndFunc
