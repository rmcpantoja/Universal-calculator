; program compiler:
#include <Array.au3>
#include <File.au3>
Local $aPaths = ["Documentation", _
		"images", _
		"lng"]
Local $sCopy = ""
ConsoleWrite("Compilation util: starting..." &@crlf)
if not @compiled then
	ConsoleWriteError("Error: script compiled")
	Exit
EndIf
ConsoleWrite("Compilation util: Starting paths..." & @CRLF)
_start_paths(@ScriptDir & "\..\compiled", $aPaths)
ConsoleWrite("Copying files..." & @CRLF)
_CopiFiles(@ScriptDir & "\..\compiled")
If @error Then
	ConsoleWrite("Error: ")
	Switch @error
		Case 1
			ConsoleWriteError("Base dir doesn't exists." & @CRLF)
		Case 2
			ConsoleWriteError("Required files not found." & @CRLF)
		Case 3
			ConsoleWriteError("Can't compy file." & @CRLF)
	EndSwitch
	Exit
EndIf
ConsoleWrite("Final steps: copying final folders..." & @CRLF)
$sCopy = _copyFolders(@ScriptDir & "\..\compiled", $aPaths)
If @error Then
	ConsoleWrite("Error: ")
	Switch @error
		Case 1
			ConsoleWriteError("Base dir doesn't exists." & @CRLF)
		Case 2
			ConsoleWriteError("Folder " & $sCopy & " not found." & @CRLF)
	EndSwitch
	Exit
EndIf
ConsoleWrite("Ready to compile" & @CRLF)
Func _start_paths($sBaseDir, $aPaths)
	Local $sPath = ""
	If Not FileExists($sBaseDir) Then DirCreate($sBaseDir)
	For $sPath In $aPaths
		If Not FileExists($sBaseDir & "\" & $sPath) Then DirCreate($sBaseDir & "\" & $sPath)
	Next
	Return 1
EndFunc   ;==>_start_paths
Func _CopiFiles($sBaseDir)
	Local $aFiles
	If Not FileExists($sBaseDir) Then Return SetError(1, 0, "") ; please call to _start_paths first
	$aFiles = _FileListToArrayRec(@ScriptDir, "nvdaControllerClient32.dll;sounds.dat", $FLTAR_FILES, $FLTAR_NORECUR, $FLTAR_SORT)
	If @error Then Return SetError(2, 0, "")
	For $I = 1 To $aFiles[0]
		If Not FileExists($aFiles) Then FileCopy($aFiles[$I], $sBaseDir)
		If @error Then
			ExitLoop
			Return SetError(3, 0, "")
		EndIf
	Next
	Return 1
EndFunc   ;==>_CopiFiles
Func _copyFolders($sBaseDir, $aPaths)
	Local $sPath
	If Not FileExists($sBaseDir) Then Return SetError(1, 0, "") ; please call to _start_paths first
	For $sPath In $aPaths
		If Not FileExists(@ScriptDir & "\" & $sPath) Then Return SetError(2, 0, $sPath)
		DirCopy(@ScriptDir & "\" & $sPath, $sBaseDir & "\" & $sPath)
	Next
	Return 1
EndFunc   ;==>_copyFolders
