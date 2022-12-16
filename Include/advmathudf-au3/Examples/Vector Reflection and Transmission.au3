#cs ----------------------------------------------------------------------------

	Example script for Advanced Math UDF
	VECTOR REFLECTION & TRANSMISSION

#ce ----------------------------------------------------------------------------

#include <GUIConstants.au3>
#include <GDIPlus.au3>
#include <Misc.au3>

#include "..\Math.au3"

Global $Normal = Vector(0, -1) ; we will project everything to 2D, so we'll skip the third argument (it's 0 by default)
Global $Incoming = VectorNormalize(Vector(1, 1))
Global $Reflected = VectorReflect($Incoming, $Normal)

Global $IOR = 1.7
Global $Transmitted = VectorTransmit($Incoming, $Normal, $IOR)

$hGUI = GUICreate("Advanced Math UDF - Vector Reflection and Transmission (drag to change the angle)", 700, 700)
GUISetBkColor(0xFFFFFF)
GUISetState()

_GDIPlus_Startup()

$hGpx = _GDIPlus_GraphicsCreateFromHWND($hGUI)
$hBufBmp = _GDIPlus_BitmapCreateFromScan0(700, 700)
$hBufGpx = _GDIPlus_ImageGetGraphicsContext($hBufBmp)
_GDIPlus_GraphicsSetSmoothingMode($hBufGpx, 5)

$pIncoming = _GDIPlus_PenCreate(0xFF000000, 3)
$pNormal = _GDIPlus_PenCreate(0xFF0000FF, 1)
$pReflected = _GDIPlus_PenCreate(0xFF008000, 2)
$pTransmitted = _GDIPlus_PenCreate(0xFFFF0000, 2)
_GDIPlus_PenSetDashStyle($pTransmitted, 2)
$pNormal2 = _GDIPlus_PenCreate(0x6F0000FF, 1)
_GDIPlus_PenSetDashStyle($pNormal2, 1)

$bSurface = _GDIPlus_BrushCreateSolid(0xFFDDDDDD)

_Render()

While 1
	If _IsPressed(1) And WinActive($hGUI) Then
		$cInfo = GUIGetCursorInfo($hGUI)

		$Incoming = VectorNormalize(VectorNegate(Vector($cInfo[0] - 350, $cInfo[1] - 350)))
		$Reflected = VectorReflect($Incoming, $Normal)
		$Transmitted = VectorTransmit($Incoming, $Normal, $IOR)

		_Render()
	EndIf

	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			ExitLoop
	EndSwitch
WEnd

_GDIPlus_BrushDispose($bSurface)

_GDIPlus_PenDispose($pNormal2)
_GDIPlus_PenDispose($pTransmitted)
_GDIPlus_PenDispose($pReflected)
_GDIPlus_PenDispose($pNormal)
_GDIPlus_PenDispose($pIncoming)

_GDIPlus_GraphicsDispose($hBufGpx)
_GDIPlus_BitmapDispose($hBufBmp)
_GDIPlus_GraphicsDispose($hGpx)

_GDIPlus_Shutdown()

Func _Render()
	_GDIPlus_GraphicsClear($hBufGpx, 0xFFFFFFFF)

	_GDIPlus_GraphicsFillRect($hBufGpx, 0, 350, 700, 350, $bSurface) ; "surface"

	_GDIPlus_GraphicsDrawLine($hBufGpx, 350, 350, 350 - $Incoming[0]*1000, 350 - $Incoming[1]*1000, $pIncoming) ; incoming vector
	_GDIPlus_GraphicsDrawLine($hBufGpx, 350, 350, 350 + $Normal[0]*1000, 350 + $Normal[1]*1000, $pNormal) ; "surface" normal
	_GDIPlus_GraphicsDrawLine($hBufGpx, 350, 350, 350 - $Reflected[0]*1000, 350 - $Reflected[1]*1000, $pReflected) ; reflected vector
	_GDIPlus_GraphicsDrawLine($hBufGpx, 350, 350, 350 + $Transmitted[0]*1000, 350 + $Transmitted[1]*1000, $pTransmitted) ; reflected vector
	_GDIPlus_GraphicsDrawLine($hBufGpx, 350, 350, 350 - $Normal[0]*1000, 350 - $Normal[1]*1000, $pNormal2) ; "surface" normal, below

	_GDIPlus_GraphicsDrawImage($hGpx, $hBufBmp, 0, 0)
EndFunc
