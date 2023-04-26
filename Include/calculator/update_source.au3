; Update and check the latest repo:
#include <InetConstants.au3>
#include "..\zip.au3"
#include-once

Func _GetLastCommit($sOwner, $sRepo)
	Local $oHTTP = ObjCreate("WinHttp.WinHttpRequest.5.1")
	$oHTTP.Open("GET", "https://api.github.com/repos/" & $sOwner & "/" & $sRepo & "/commits", False)
	$oHTTP.setRequestHeader("User-Agent", "Mozilla/5.0")
	$oHTTP.setRequestHeader("Accept", "application/vnd.github+json")
	$oHTTP.Send()
	If $oHTTP.Status <> 200 Then Return SetError(1, 0, "")
	Local $sResponse = $oHTTP.ResponseText
	Local $aCommits = StringRegExp($sResponse, '\{"sha":"(.*?)",', 3)
	If @error Then Return SetError(2, 0, "")
	Return $aCommits[0]
EndFunc

Func _download_Github_repo($sRepoURL, $sFileName, $sDestinationFolder)
	Local $iRet = InetGet($sRepoURL, $sDestinationFolder & "\" & $sFileName, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)
	If $iRet == 0 Then return SetError(1, 0, "")
	ProgressOn("Downloading", "Downloading latest repo updates...", "0%")
	While InetGetInfo($iRet, $INET_DOWNLOADCOMPLETE) = 0
		$iBytesRead = InetGetInfo($iRet, $INET_DOWNLOADREAD)
		$iTotalBytes = InetGetInfo($iRet, $INET_DOWNLOADSIZE)
		$iProgress = Round(($iBytesRead / $iTotalBytes) * 100, 0)
		ProgressSet($iProgress)
		Sleep(10)
	WEnd
	ProgressSet(100, "Done!")
	Sleep(1000)
	ProgressOff()
	if not FileExists($sDestinationFolder & "\" & $sFileName) then return SetError(2, 0, "")
	$oShell = ObjCreate("WScript.Shell")
	$sCommand = 'Expand-Archive "' & $sDestinationFolder & "\" & $sFileName & '" -DestinationPath "' & @ScriptDir & '" -Force -Verbose'
	$oShell.Run('powershell.exe -Command "' & $sCommand & '"')
	ProcessWait("powershell.exe")
	DirMove (@ScriptDir &"\Universal-calculator-main", @ScriptDir, 1)
	FileDelete($sDestinationFolder & "\" &$sFileName)
	return True
EndFunc