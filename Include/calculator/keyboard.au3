#include "globals.au3"
#include <GuiConstantsEx.au3>
#include "options.au3"
#include "..\reader.au3"
#include "..\translator.au3"
#include-once
Local $aCalculatorKeys[15][2] = [ _
		[0, "{numpad0}"], _
		[1, "{numpad1}"], _
		[2, "{numpad2}"], _
		[3, "{numpad3}"], _
		["-", "{NUMPADSUB}"], _
		[4, "{numpad4}"], _
		[5, "{numpad5}"], _
		[6, "{numpad6}"], _
		["*", "{NUMPADMULT}"], _
		[7, "{numpad7}"], _
		[8, "{numpad8}"], _
		[9, "{numpad9}"], _
		["/", "{NUMPADDIV}"], _
		[".", "{NUMPADDOT}"], _
		["+", "{NUMPADADD}"] _
		]

; #FUNCTION# ====================================================================================================================
; Name ..........: _IsChecked
; Description ...: check if a control is checked
; Syntax ........: _IsChecked($idControlID)
; Parameters ....: $idControlID         - An AutoIt controlID.
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked

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
Func _addSymbol($hGui, $idSymbolButton, $sEnhancedAccessibility, $bSpeak_numbers)
	Local $sText
	$sText = ControlGetText($hGui, "", "Edit1")
	; we place said number or symbol to the field:
	ControlSetText($hGui, "", "Edit1", $sText & ControlGetText($hGui, "", $idSymbolButton))
	If $sEnhancedAccessibility = "yes" And $bSpeak_numbers Then speaking(ControlGetText($hGui, "", $idSymbolButton), True)
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
Func _HideKey($aKeyControls, $idHideKeyControl, ByRef $bHideKeyboard)
	If Not $bHideKeyboard Then
		; we make a for to hide all keyboard controls based on the array we created:
		For $I = 0 To UBound($aKeyControls)
			GUICtrlSetState($aNums[$I], $GUI_hide)
		Next
		$bHideKeyboard = True
		GUICtrlSetState($idHideKeyControl, $GUI_CHECKED)
		If $sEnhancedAccessibility = "Yes" Then speaking(Translate($sLang, "Keyboard hidden"))
	Else
		; here we do the opposite, we show it.
		For $I = 0 To UBound($aNums)
			GUICtrlSetState($aNums[$I], $GUI_SHOW)
		Next
		$bHideKeyboard = False
		GUICtrlSetState($idHideKey, $GUI_unchecked)
		If $sEnhancedAccessibility = "Yes" Then speaking(Translate($sLang, "Keyboard shown"))
	EndIf
EndFunc   ;==>_HideKey

; #FUNCTION# ====================================================================================================================
; Name ..........: _switch_read_keys
; Description ...: Change the state to say the written numbers for enhanced accessibility.
; Syntax ........: _switch_read_keys()
; Parameters ....: None
; Return values .: None
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _switch_read_keys()
	If Not $bSpeak_numbers Then
		$bSpeak_numbers = True
		speaking(Translate($sLang, "Character reading enabled"), True)
	Else
		$bSpeak_numbers = False
		speaking(Translate($sLang, "Character reading disabled"), True)
	EndIf
EndFunc   ;==>_switch_read_keys

; #FUNCTION# ====================================================================================================================
; Name ..........: _convert_key_from_keymap
; Description ...: Convert a key to a compatible one to establish key mappings
; Syntax ........: _convert_key_from_keymap($iIndice)
; Parameters ....: $iIndice             - the index of the key to convert.
; Return values .: The converted key. @error=1 if $iInt is not an integer and $error = 2 if the index is greater than 14.
; Author ........: Mateo Cedillo
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _convert_key_from_keymap($iIndice)
	If Not IsInt($iIndice) Then Return SetError(1, 0, "")
	If $iIndice > 14 Then Return SetError(2, 0, "")
	Return $aCalculatorKeys[$iIndice][1]
EndFunc   ;==>_convert_key_from_keymap

; #FUNCTION# ====================================================================================================================
; Name ..........: _scriftkey_options
; Description ...:
; Syntax ........: _scriftkey_options()
; Parameters ....: None
; Return values .: None
; Author ........: Your Name
; Modified ......:
; Remarks .......:
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func _scriftkey_options()
	Return _accessibility_Options($sConfigFolder, $sConfigPath)
EndFunc   ;==>_scriftkey_options

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
	If GUICtrlRead($idScreenControl) = "" or UBound($aStoreOperators) = 0 Then
		If $sEnhancedAccessibility = "Yes" Then
			Speaking(Translate($sLang, "there's nothing to clean"))
		Else
			MsgBox(16, Translate($sLang, "Error"), Translate($sLang, "there's nothing to clean"))
		EndIf
	Else
		GUICtrlSetData($idScreenControl, "")
		ReDim $aStoreOperators[0]
		$sInterOperacion = ""
		$nResult = ""
		If $sEnhancedAccessibility = "Yes" Then speaking(Translate($sLang, "Screen cleaned"))
	EndIf
EndFunc   ;==>_ClearScreen
