#include <ScreenCapture.au3>

Example()

Func Example()
	;$hWND = WinWaitActive("Universal calculator v0.1a2")
	$hWND = WinWaitActive("Opciones")
	; Capture window
	_ScreenCapture_CaptureWnd(@ScriptDir & "\Calculator_test.jpg", $hWND)
	beep(2200, 60)
	sleep(1000)
EndFunc   ;==>Example
