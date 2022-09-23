#include <ScreenCapture.au3>

Example()

Func Example()
	$hWND = WinWaitActive("Universal calculator 0.1")
	; Capture window
	_ScreenCapture_CaptureWnd(@ScriptDir & "\Calculator_test.jpg", $hWND)
	beep(2200, 60)
	sleep(1000)
EndFunc   ;==>Example
