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
Global $sLanguage = IniRead(@ScriptDir &"\config\config.st", "General settings", "language", "En")
_updater()
func _updater()
; Command line updater:
if uBound($CmdLine) -1 > 2 then
_Updater_Update($CmdLine[1], $CmdLine[2], $CmdLine[3])
EndIf
EndFunc
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
	local $bUpdatable = False
	local $sLatestver
	Local $oErrorHandler = ObjEvent("AutoIt.Error", "_ErrFunc")
	Local $oHTTP = ObjCreate("WinHttp.WinHttpRequest.5.1")
	$oHTTP.Open("GET", "https://api.github.com/repos/" & $sGitHubURL & "/releases", False)
	If (@error) Then Return SetError(1, 0, "")
	$oHTTP.Send()
	If (@error) Then Return SetError(2, 0, "")
	If $oHTTP.Status <> 200 Then Return SetError(3, 0, "")
	Local $sResponse = $oHTTP.ResponseText
	; changes here:
	local $sLatestver = StringRegExp($sResponse, "v\d\.\d+[a-zA-Z]?\d*", 3)[0]
	If @error Then Return SetError(4, 0, "")
	$iComparison = _VersionCompare($sLatestver, $sCurrentVersion) 
		Select
			case $sLatestver = ""
				if not $bSylent then MSGBox(16, translate($sLanguage, "Error"), translate($sLanguage, "Unable to connect to the server. The server went down or you don't have an internet connection."))
			Case $sLatestver = "0"
				if not $bSylent then MsgBox(16, translate($sLanguage, "Error"), translate($sLanguage, "version could not be checked."))
		EndSelect
		if $iComparison = -1 or $iComparison = 1 then
			MsgBox(48, translate($sLanguage, "update available!"), translate($sLanguage, "You have the version") &" " &$sCurrentVersion &" " &translate($sLanguage, "And is available the") &" " &$sLatestver &".")
			$bUpdatable = True
		elseIf $iComparison = 0 then
			if not $bSylent then MsgBox(48, translate($sLanguage, "you are up to date"), translate($sLanguage, "no update at the moment."))
		EndIf
	local $aReturn = [$bUpdatable, $sLatestver, $sResponse]
	return $aReturn
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
	Local Static $aSize[4] = ["Bytes", "KB", "MB", "GB"]
	For $i = 0 To 3
		$iTotalDownloaded /= 1024
		If (Int($iTotalDownloaded) = 0) Then Return Round($iTotalDownloaded * 1024, $iPlaces) & " " & $aSize[$i]
	Next
EndFunc   ;==>_GetDisplaySize
; #FUNCTION# ====================================================================================================================
; Name ..........: _Updater_Update
; Description ...: updater
; Syntax ........: _Updater_Update($S_executable, $S_URLinstallable, $S_URLPortable)
; Parameters ....: $S_executable        - A string value.
;                  $S_URLinstallable    - A string value.
;                  $S_URLPortable       - A string value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _Updater_Update($sExecutable, $sURL, $sFileDestionation)
	ProgressOn(translate($sLanguage, "Downloading update."), translate($sLanguage, "Please wait..."), "0%", 100, 100, 16)
	WinActivate(translate($sLanguage, "Downloading update."))
	$iPlaces = 2
	$hInet = InetGet($sURL, $sFileDestionation, 1, 1)
	$URLSize = InetGetSize($sURL)
	if @error then MsgBox(16, "Error", "Can't download the update. Make sure you habe internet conection.")
	While Not InetGetInfo($hInet, 2)
		Sleep(50)
		$Size = InetGetInfo($hInet, 0)
		$Percentage = Int($Size / $URLSize * 100)
		$iSize = $URLSize - $Size
		ProgressSet($Percentage, _GetDisplaySize($iSize, $iPlaces = 2) & " " & translate($sLanguage, "remaining") & $Percentage & " " & translate($sLanguage, "percent completed"))
		If _IsPressed($i) Then
			speaking(translate($sLanguage, "FileSize in bites:") & " " & $URLSize & ". " & translate($sLanguage, "Downloaded:") & " " & $Size & ". " & translate($sLanguage, "Progress:") & " " & $Percentage & "%. " & translate($sLanguage, "Remaining size:") & " " & $iSize)
			MsgBox(0, "Information", translate($sLanguage, "FileSize in bites:") & " " & $URLSize & ". " & translate($sLanguage, "Downloaded:") & " " & $Size & ". " & translate($sLanguage, "Progress:") & " " & $Percentage & "%. " & translate($sLanguage, "Remaining size:") & " " & $iSize)
		EndIf
	WEnd
	ProgressSet(99, translate($sLanguage, "Installing update."), translate($sLanguage, "Please wait while the program updates"))
	$sProcess = ProcessExists($sExecutable)
	If Not $sProcess = 0 Then
		ProcessClose($sExecutable)
		if @error then
			MsgBox(16, "Updater error", "Can't terminate the process. Error code: " &@error &@crlf &"Please contact with the project mantainers.")
			exit
		EndIf
	EndIf
	_Zip_UnzipAll(@ScriptDir &"\" & $sFileDestionation, @ScriptDir, 20)
	if @error then
		MsgBox(16, "Error", "Couldn't extract update! Error code: " &@error & @crlf & "Please contact with the project mantainers.")
		exit
	EndIf
	sleep(1000)
	FileDelete(@ScriptDir &"\" & $sFileDestionation)
	ProgressOff()
	return Run($sExecutable)
EndFunc   ;==>_Updater_Update