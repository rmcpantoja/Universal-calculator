#include <ScreenCapture.au3>

Example()

Func Example()
	$hWND = WinWaitActive("Universal calculator v0.1a5")
	;$hWND = WinWaitActive("Opciones")
	; Capture window
	_ScreenCapture_CaptureWnd(@ScriptDir & "\images\Calculator_test_for_presentation.jpg", $hWND)
	beep(2200, 60)
	sleep(1000)
EndFunc   ;==>Example
