#include "globals.au3"
#include <GuiConstantsEx.au3>
#include "..\reader.au3"
#include "..\translator.au3"
#include-once
#include-once
; #FUNCTION# ====================================================================================================================
; Name ..........: _IsFocused
; Description ...: Check if a control is focused.
; Syntax ........: _IsFocused($hWnd, $iControlID)
; Parameters ....: $hWnd                - a handle value.
;                  $iControlID          - an integer value.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IsFocused($hWnd, $iControlID)
	Return ControlGetHandle($hWnd, "", $iControlID) = ControlGetHandle($hWnd, "", ControlGetFocus($hWnd))
EndFunc   ;==>_IsFocused
; #FUNCTION# ====================================================================================================================
; Name ..........: _addSymbol
; Description ...: Adds a symbol (character either numbers or signs) to the interaction input box.
; Syntax ........: _addSymbol($idSymbolButton)
; Parameters ....: $idSymbolButton      - The input box to do in.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _addSymbol($hGui, $idSymbolButton)
	Local $sText
	$sText = ControlGetText($hGUI, "", "Edit1")
	; we place said number or symbol to the field:
	ControlSetText($hGUI, "", "Edit1", $sText & ControlGetText($hGUI, "", $idSymbolButton))
EndFunc   ;==>_addSymbol
; #FUNCTION# ====================================================================================================================
; Name ..........: _HideKey
; Description ...: function used within the GUI to show and hide the keyboard.
; Syntax ........: _HideKey()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _HideKey($aKeyControls, $idHideKeyControl, byRef $bHideKeyboard)
	If Not $bHideKeyboard Then
		; we make a for to hide all keyboard controls based on the array we created:
		For $I = 0 To UBound($aKeyControls)
			GUICtrlSetState($aNums[$I], $GUI_hide)
		Next
		$bHideKeyboard = True
		GUICtrlSetState($idHideKeyControl, $GUI_checked)
		if $sEnhancedAccess = "Yes" then speaking(Translate($sLang, "Keyboard hidden"))
	Else
		; here we do the opposite, we show it.
		For $I = 0 To UBound($aNums)
			GUICtrlSetState($aNums[$I], $GUI_SHOW)
		Next
		$bHideKeyboard = False
		GUICtrlSetState($idHideKey, $GUI_unchecked)
		if $sEnhancedAccess = "Yes" then speaking(Translate($sLang, "Keyboard shown"))
	EndIf
EndFunc   ;==>_HideKey
; #FUNCTION# ====================================================================================================================
; Name ..........: _ClearScreen
; Description ...: function used to clear the calculator screen, including results.
; Syntax ........: _ClearScreen()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _ClearScreen($idScreenControl)
	If GUICtrlRead($idScreenControl) = "" Then
		if $sEnhancedAccess = "Yes" then
			Speaking(Translate($sLang, "there's nothing to clean"))
		Else
			MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "there's nothing to clean"))
		EndIf
	Else
		GUICtrlSetData($idScreenControl, "")
		$sInterOperacion = ""
		$nResult = ""
		if $sEnhancedAccess = "Yes" then speaking(Translate($sLang, "Screen cleaned"))
	EndIf
EndFunc   ;==>_ClearScreen