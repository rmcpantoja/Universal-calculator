; Update and check the latest repo:
#include "..\error_reporter.au3"
#include "globals.au3"
#include <InetConstants.au3>
#include "..\translator.au3"
#include "..\_zip.au3"
#include-once

; #FUNCTION# ====================================================================================================================
; Name ..........: _GetLastCommit
; Description ...: Gets the latest commit for a given repository on GitHub.
; Syntax ........: _GetLastCommit($sOwner, $sRepo)
; Parameters ....: $sOwner              - The owner or username.
;                  $sRepo               - the name of the repository.
; Return values .: The last commit
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _GetLastCommit($sOwner, $sRepo)
	Local $oErrorHandler = ObjEvent("AutoIt.Error", "_ErrFunc")
	Local $oHTTP = ObjCreate("WinHttp.WinHttpRequest.5.1")
	$oHTTP.Open("GET", "https://api.github.com/repos/" & $sOwner & "/" & $sRepo & "/commits", False)
	If (@error) Then Return SetError(1, 0, "error")
	$oHTTP.setRequestHeader("User-Agent", "Mozilla/5.0")
	$oHTTP.setRequestHeader("Accept", "application/vnd.github+json")
	$oHTTP.Send()
	If (@error) Then Return SetError(2, 0, "error")
	If $oHTTP.Status <> 200 Then Return SetError(3, 0, "error")
	Local $sResponse = $oHTTP.ResponseText
	Local $aCommits = StringRegExp($sResponse, '\{"sha":"(.*?)",', 3)
	If @error Then Return SetError(4, 0, "error")
	Return $aCommits[0]
EndFunc   ;==>_GetLastCommit

; #FUNCTION# ====================================================================================================================
; Name ..........: _download_Github_repo
; Description ...: Download a given repository from GitHub.
; Syntax ........: _download_Github_repo($sRepoURL, $sFileName, $sDestinationFolder)
; Parameters ....: $sRepoURL            - A string containing the URL of the repository to download.
;                  $sFileName           - The zip file name.
;                  $sDestinationFolder  - Where to save this file.
; Return values .: Returns true if all went well, otherwise @error at 1 if the server could not be connected, and 2 if the file could not be downloaded.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: Yes
; ===============================================================================================================================
Func _download_Github_repo($sRepoURL, $sFileName, $sDestinationFolder)
	Local $iRet = InetGet($sRepoURL, $sDestinationFolder & "\" & $sFileName, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)
	If $iRet == 0 Then Return SetError(1, 0, "")
	ProgressOn(translate($sLang, "Downloading"), translate($sLang, "Downloading latest repo updates..."), "0%")
	While InetGetInfo($iRet, $INET_DOWNLOADCOMPLETE) = 0
		$iBytesRead = InetGetInfo($iRet, $INET_DOWNLOADREAD)
		$iTotalBytes = InetGetInfo($iRet, $INET_DOWNLOADSIZE)
		$iProgress = Round(($iBytesRead / $iTotalBytes) * 100, 0)
		ProgressSet($iProgress)
		Sleep(10)
	WEnd
	ProgressSet(100, translate($sLang, "Done!"))
	Sleep(1000)
	ProgressOff()
	If Not FileExists($sDestinationFolder & "\" & $sFileName) Then Return SetError(2, 0, "")
	_Zip_UnzipAll($sDestinationFolder & "\" & $sFileName, @ScriptDir, 20)
	If @error Then Return SetError(3, 0, "")
	; move dirs:
	DirMove(@ScriptDir & "\Universal-calculator-main\*", @ScriptDir, 1)
	; move files:
	FileMove(@ScriptDir & "\Universal-calculator-main\*", @ScriptDir, 9)
	FileDelete($sDestinationFolder & "\" & $sFileName)
	Return True
EndFunc   ;==>_download_Github_repo
