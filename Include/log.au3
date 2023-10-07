#include-once
#include <fileConstants.au3>
Local $hLogFile
$sLogPath = @ScriptDir & "\logs"
$SSave = ""

; #FUNCTION# ====================================================================================================================
; Name ..........: log_start
; Description ...: Starts a log file.
; Syntax ........: log_start()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func log_start()
	Local $logfile
	$SSave = IniRead(@ScriptDir & "\config\config.st", "General settings", "Save Logs", "")
	Select
		Case $SSave = ""
			IniWrite(@ScriptDir & "\config\config.st", "General settings", "Save Logs", "Yes")
			$SSave = "Yes"
	EndSelect
	If $SSave = "Yes" Then $hLogFile = FileOpen($sLogPath & "\" & @YEAR & @MON & @MDAY & ".log", $FC_OVERWRITE + $FC_CREATEPATH)
EndFunc   ;==>log_start
; #FUNCTION# ====================================================================================================================
; Name ..........: writeinlog
; Description ...: write a text or information to the log
; Syntax ........: writeinlog($text)
; Parameters ....: $text                - A dll struct value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func writeinlog($text)
	If $SSave = "yes" Then
		FileWrite($hLogFile, @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ": " & $text & @CRLF)
	EndIf
EndFunc   ;==>writeinlog
; #FUNCTION# ====================================================================================================================
; Name ..........: ___DeBug
; Description ...: write an error to the log
; Syntax ........: ___DeBug($iError, $sAction)
; Parameters ....: $iError              - A integer value.
;                  $sAction             - A string value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func ___DeBug($iError, $sAction)
	Switch $iError
		Case -1
			FileWrite($hLogFile, @CRLF & "-" & $sAction & @CRLF)
		Case 0
			FileWrite($hLogFile, @CRLF & "+" & $sAction & " - OK" & @CRLF)
		Case Else
			FileWrite($hLogFile, @CRLF & "!" & $sAction & " - FAILED" & @CRLF)
			Exit
	EndSwitch
EndFunc   ;==>___DeBug
