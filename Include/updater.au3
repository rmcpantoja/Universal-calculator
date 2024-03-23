;Auto Actualizador (Auto updater)
;Created by Mateo Cedillo.
;Script:
;Including scripts
#include "_zip.au3"
#include <AutoItConstants.au3>
#include <Misc.au3>
#include "reader.au3"
#include "translator.au3"
#include-once
Global $sLanguage = IniRead(@ScriptDir & "\config\config.st", "General settings", "language", "En")
_updater()
; #FUNCTION# ====================================================================================================================
; Name ..........: _updater
; Description ...: Command line updater
; Syntax ........: _updater()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _updater()
	If UBound($CmdLine) - 1 > 2 Then
		_Updater_Update($CmdLine[1], $CmdLine[2], $CmdLine[3])
	EndIf
EndFunc   ;==>_updater
; #FUNCTION# ====================================================================================================================
; Name ..........: checkupdate
; Description ...: function that allows you to check for updates to a program
; Syntax ........: checkupdate($S_Program, $s_executable, $s_DatURL, $s_Window)
; Parameters ....: $S_Program           - A string value.
;                  $s_executable        - A string value.
;                  $s_DatURL            - A string value.
;                  $s_Window            - A string value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func checkupdate($sCurrentVersion, $sGitHubURL, $bSylent = False)
	Local $bUpdatable = False
	Local $sLatestver
	Local $oErrorHandler = ObjEvent("AutoIt.Error", "_ErrFunc")
	Local $oHTTP = ObjCreate("WinHttp.WinHttpRequest.5.1")
	$oHTTP.Open("GET", "https://api.github.com/repos/" & $sGitHubURL & "/releases", False)
	If (@error) Then Return SetError(1, 0, "")
	$oHTTP.Send()
	If (@error) Then Return SetError(2, 0, "")
	If $oHTTP.Status <> 200 Then Return SetError(3, 0, "")
	Local $sResponse = $oHTTP.ResponseText
	Local $sLatestver = StringRegExp($sResponse, "v\d\.\d+[a-zA-Z]?\d*", 3)[0]
	If @error Then Return SetError(4, 0, "")
	$iComparison = _VersionCompare($sLatestver, $sCurrentVersion)
	Select
		Case $sLatestver = ""
			If Not $bSylent Then
				MsgBox(16, _
						translate($sLanguage, "Error"), _
						translate($sLanguage, "Unable to connect to the server. The server went down or you don't have an internet connection.") _
						)
			EndIf
		Case $sLatestver = "0"
			If Not $bSylent Then
				MsgBox(16, translate($sLanguage, "Error"), translate($sLanguage, "version could not be checked."))
			EndIf
	EndSelect
	If $iComparison = -1 Or $iComparison = 1 Then
		MsgBox(48, _
				translate($sLanguage, "update available!"), _
				translate($sLanguage, "You have the version") & " " & $sCurrentVersion & " " & translate($sLanguage, "And is available the") & " " & $sLatestver & "." _
				)
		$bUpdatable = True
	ElseIf $iComparison = 0 Then
		If Not $bSylent Then
			MsgBox(48, translate($sLanguage, "you are up to date"), translate($sLanguage, "no update at the moment."))
		EndIf
	EndIf
	Local $aReturn = [$bUpdatable, $sLatestver, $sResponse]
	Return $aReturn
EndFunc   ;==>checkupdate
; #FUNCTION# ====================================================================================================================
; Name ..........: _GetDisplaySize
; Description ...: get information relevant to downloads
; Syntax ........: _GetDisplaySize($iTotalDownloaded, Const $iPlaces)
; Parameters ....: $iTotalDownloaded    - A integer value.
;                  Const $iPlaces       - An unknown value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _GetDisplaySize($iTotalDownloaded, Const $iPlaces)
	Local Static $aSize[5] = ["Bytes", "KB", "MB", "GB", "TB"]
	For $i = 0 To 3
		$iTotalDownloaded /= 1024
		If (Int($iTotalDownloaded) = 0) Then Return Round($iTotalDownloaded * 1024, $iPlaces) & " " & $aSize[$i]
	Next
EndFunc   ;==>_GetDisplaySize
; #FUNCTION# ====================================================================================================================
; Name ..........: _Updater_Update
; Description ...: performs an update to an app.
; Syntax ........: _Updater_Update($S_executable, $S_URLinstallable, $S_URLPortable)
; Parameters ....: $S_executable        - The process to kill if the app is running.
;                  $S_URLinstallable    - The direct URL to installable version.
;                  $S_URLPortable       - Direct URL to the portable version (zip).
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Updater_Update($sExecutable, $sURL, $sFileDestination)
	ProgressOn( _
			translate($sLanguage, "Downloading update."), translate($sLanguage, "Please wait..."), "0%", 100, 100, 16 _
			)
	WinActivate(translate($sLanguage, "Downloading update."))
	$iPlaces = 2
	$hInet = InetGet($sURL, $sFileDestination, 1, 1)
	$URLSize = InetGetSize($sURL)
	If @error Then MsgBox(16, "Error", "Can't download the update. Make sure you habe internet conection.")
	While Not InetGetInfo($hInet, 2)
		Sleep(50)
		$Size = InetGetInfo($hInet, 0)
		$Percentage = Int($Size / $URLSize * 100)
		$iSize = $URLSize - $Size
		ProgressSet($Percentage, _
				_GetDisplaySize($iSize, $iPlaces = 2) & " " & translate($sLanguage, "remaining") & $Percentage & " " & translate($sLanguage, "percent completed") _
				)
		If _IsPressed($i) Then
			speaking( _
					translate($sLanguage, "FileSize in bites:") & " " & $URLSize & ". " & _
					translate($sLanguage, "Downloaded:") & " " & $Size & ". " & _
					translate($sLanguage, "Progress:") & " " & $Percentage & "%. " & _
					translate($sLanguage, "Remaining size:") & " " & $iSize _
					)
			MsgBox(0, _
					"Information", _
					translate($sLanguage, "FileSize in bites:") & " " & $URLSize & ". " & _
					translate($sLanguage, "Downloaded:") & " " & $Size & ". " & _
					translate($sLanguage, "Progress:") & " " & $Percentage & "%. " & _
					translate($sLanguage, "Remaining size:") & " " & $iSize _
					)
		EndIf
	WEnd
	ProgressSet(99, translate($sLanguage, "Installing update."), translate($sLanguage, "Please wait while the program updates"))
	$sProcess = ProcessExists($sExecutable)
	If $sProcess Then
		ProcessClose($sExecutable)
		If @error Then
			MsgBox(16, _
					"Updater error", _
					"Can't terminate the process. Error code: " & @error & @CRLF & "Please contact with the project mantainers." _
					)
			Exit
		EndIf
	EndIf
	_Zip_UnzipAll($sFileDestination, @ScriptDir, 20)
	If @error Then
		MsgBox(16, _
				"Error", _
				"Couldn't extract update! Error code: " & @error & @CRLF & "Please contact with the project mantainers." _
				)
		Exit
	EndIf
	FileDelete(@ScriptDir & "\" & $sFileDestination)
	ProgressOff()
	Return Run($sExecutable)
EndFunc   ;==>_Updater_Update
