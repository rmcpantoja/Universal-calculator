#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _ErrFunc
; Description ...: User's COM error function. Will be called if COM error occurs.
; Syntax ........: _ErrFunc($oError)
; Parameters ....: $oError              - an object.
; Return values .: None
; Author ........:
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _ErrFunc()
	local $sMessageType
	; Do anything here.
	;if $sType == "internet" then
	;	$sMessageType = "Well, it seems that you have problems with your internet connection, useful for checking for updates to both the program and the source code, so you will work offline for now."
	ConsoleWrite(@ScriptName & " (" & $oError.scriptline & ") : ==> COM Error intercepted !" & @CRLF & _
			@TAB & "Error code: " & @TAB & @TAB & "0x" & Hex($oError.number) & @CRLF & _
			@TAB & "Error Description:" & @TAB & $oError.windescription & @CRLF & _
			@TAB & "error AutoIt description: " & @TAB & $oError.description & @CRLF & _
			;@TAB & "Message: " & @TAB & $sMessageType & @CRLF & _
			@TAB & "Source: " & @TAB & @TAB & $oError.source & @CRLF & _
			@TAB & "Help file: " & @TAB & $oError.helpfile & @CRLF & _
			@TAB & "Help context: " & @TAB & $oError.helpcontext & @CRLF & _
			@TAB & "last DLL error: " & @TAB & $oError.lastdllerror & @CRLF & _
			@TAB & "Script line where the error occurs: " & @TAB & $oError.scriptline & @CRLF & _
			@TAB & "Return code: " & @TAB & "0x" & Hex($oError.retcode) & @CRLF & @CRLF)
EndFunc   ;==>_ErrFunc
