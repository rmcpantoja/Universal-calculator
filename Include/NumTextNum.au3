;~ #AutoIt3Wrapper_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include-once
#include <StringConstants.au3>
#include <Array.au3>

Global Const $N2T_LANGENGLISH = 0
Global Const $N2T_LANGSPANISH = 1

;~ ConsoleWrite( _
;~ 		_AutCode_NumberToText($gsStr, False, "", "", $N2T_LANGSPANISH) & " : " & TimerDiff($giTimer) / 1000 & @CRLF)

; $vNum ........ = The english/spanish number to turn to text
;                   (length max is 999 sextillion, a max of 24 chars)
; $bRetDecimal . = Return the decimal value (default) or just the whole numbers
; $sRetThoDelim  = The separator for the thousands
;                   (blocks of 3 numbers that were sent, but not necessarily what will be returned)
;                  This could be because 1,094,012 was sent, ninety four thousand could have a
;                   separator after the thousand
; $sRetDecDelim  = The decimal (floating after decimal) delim to send back
; $iLang.......  = The language to translate, currently $N2T_LANGENGLISH (default) or $N2T_LANGSPANISH
; $sLangThoSep.  = The thousands separator of the $vNum you're sending
;                   (default is english separators) (changes per language)
; $sLangDecSep.  = The decimal separator of the $vNum value
;                   (default is english separators) (changes per language)

Func _AutCode_NumberToText($vNum, $bRetDecimal = True, $sRetThoDelim = "", $sRetDecDelim = "", _
		$iLang = $N2T_LANGENGLISH, $sLangThoSep = ",", $sLangDecSep = ".")

	Local $iLen = StringLen($vNum)

	Switch $iLang
		Case $N2T_LANGSPANISH
			; in spanish, the number thousands speparator is only for
			;  number groups of more than 4 digits
			If $iLen < 5 Then $sRetThoDelim = ""
	EndSwitch

	$sLangThoSep = _AutCode_EscapeDelimiters($sLangThoSep)
	$sLangDecSep = _AutCode_EscapeDelimiters($sLangDecSep)

	; strip spaces and or thousand separators
	If StringLen($sLangThoSep) > 0 Then
		$vNum = StringRegExpReplace($vNum, "[ " & $sLangThoSep & "]", "")
	EndIf

	Local $sIsNumStrRE = "^\d+(?:" & $sLangDecSep & "\d+$|$)"
	If Not StringRegExp($vNum, $sIsNumStrRE) Then
		Return SetError(2, 0, "")
	EndIf

	Local $sNumOnlyRE = "^(\d+)(?:" & $sLangDecSep & "\d+$|$)"
	Local $sDecOnlyRE = "^(?:\d+" & $sLangDecSep & "|\d+$)"

	Local $sNum = StringRegExpReplace($vNum, $sNumOnlyRE, "$1")
	Local $sDecimal = StringRegExpReplace($vNum, $sDecOnlyRE, "")

	; get digits, if not in groups of 3 (aka hundreds) then retrieve
	;  first 1 or 2 digits that are remainder from the mod
	Local $aTmp
	Local $iMod = Mod(StringLen($sNum), 3)
	If ($iMod = 0) Then
		$aTmp = StringRegExp($sNum, "\d{3}", $STR_REGEXPARRAYGLOBALMATCH)
	Else
		$aTmp = StringRegExp($sNum, "^\d{" & $iMod & "}|\d{3}", $STR_REGEXPARRAYGLOBALMATCH)
	EndIf

	; get ub of group separators array
	Local $iNumTypeUB = __autcode_numberToText($aTmp, "", $iLang, True)
	If @error Then
		Return SetError(3, @extended, "")
	EndIf

	Local $iUB = UBound($aTmp)

	; Is the group of numbers larger than sextillion (current largest amount because spanish was hard!)
	If $iUB > $iNumTypeUB Then
		Return SetError(4, $iUB, "")
	EndIf

	Local $aDec[1] = [StringLeft($sDecimal, 2)]
	If Not $bRetDecimal Or (Int(StringLeft($sDecimal, 2)) = 0) Then
		$sDecimal = ""
	Else
		If StringLen($sDecimal) Then
			; only catching the first two of the decimal
			$sDecimal = $sRetDecDelim & __autcode_numberToText($aDec, "", $iLang)
		EndIf
	EndIf

	If $iUB = 1 Then Return __autcode_numberToText($aTmp, $sRetThoDelim, $iLang) & $sDecimal

	Local $sRet = __autcode_numberToText($aTmp, $sRetThoDelim, $iLang)

	; clean up white spaces
	Local $sREDelimClean = _AutCode_EscapeDelimiters($sRetThoDelim)
	Local $sCleanupRE = "^\h*" & $sREDelimClean & "?|\h+" & $sREDelimClean & "|" & $sREDelimClean & "?\h*$|\h*$"
	If StringLen($sRetThoDelim) > 0 Then $sRet = StringRegExpReplace($sRet, $sCleanupRE, "")

	Return StringRegExpReplace($sRet & $sDecimal, "\h\h+", " ")
EndFunc   ;==>_AutCode_NumberToText

Func _AutCode_TextToNumber($sData, $sFindThou = "", $sFindDec = "", $iLang = $N2T_LANGENGLISH, $sRetThoDelim = ",", $sRetDecDelim = ".")

	; let's make sure everything  is lower case for easier manipulation
	$sData = StringLower($sData)
	$sFindThou = StringLower($sFindThou)
	$sFindDec = StringLower($sFindDec)

	; we don't care about thousand sep, but let's remove it
	If StringLen($sFindThou) > 0 Then
		$sData = StringRegExpReplace($sData, _AutCode_EscapeDelimiters($sFindThou), "")
	EndIf

	If StringRegExp($sData, "\d") Then
		Return SetError(1, 0, "")
	EndIf

	Local $sDecimal = ""
	Local $aDecimal
	If StringLen($sFindDec) > 0 Then
		$aDecimal = StringSplit($sData, $sFindDec, $STR_ENTIRESPLIT)
		If Not @error And UBound($aDecimal) > 0 Then
			If UBound($aDecimal) - 1 > 2 Then
				Return SetError(2, 0, "")
			EndIf
			$sDecimal = StringRegExpReplace($aDecimal[2], "^\h*", "")
			$sData = StringRegExpReplace($aDecimal[1], "\h*$", "")
		EndIf
	EndIf

	Local $aRet, $aDec, $sRet, $sDec

	Local $sLangRE = "^(mil|millón|millon|billón|billon|trillón|" & _
						"trillon|cuatrillón|cuatrillon)((?:\h|\h*$))"

	Switch $iLang
		Case $N2T_LANGENGLISH
			$aRet = _autcode_textToNumberGetArrayEnglish($sData)
			If @error Then
				Return SetError(3, @error, "")
			EndIf
			If StringLen($sDecimal) > 0 Then
				$aDec = _autcode_textToNumberGetArrayEnglish($sDecimal)
				If @error Then
					Return SetError(5, @error, "")
				EndIf
			EndIf

			; concat
			For $i = 0 To UBound($aRet) - 1
				$sRet &= $aRet[$i] & $sRetThoDelim
			Next
			$sRet = StringTrimRight($sRet, 1)

			; remove leading zeros from start of string
			$sRet = StringRegExpReplace($sRet, "^[0" & _AutCode_EscapeDelimiters($sRetThoDelim) & "]+", "")
		Case $N2T_LANGSPANISH
			; if first word is mil, replace it with un mil
			;  while it's proper in spanish, it would take more checking
			;  than just swapping it out now
			$sData = StringRegExpReplace($sData, $sLangRE, "un $1$2")

			$aRet = __autcode_textToNumberGetArraySpanish($sData)
			If @error Then
				Return SetError(6, @error, "")
			EndIf
			If StringLen($sDecimal) > 0 Then
				$aDec = __autcode_textToNumberGetArraySpanish($sDecimal)
				If @error Then
					Return SetError(7, @error, "")
				EndIf
			EndIf
			; concat
			For $i = 0 To UBound($aRet) - 1
				$sRet &= $aRet[$i] & $sRetThoDelim
			Next
			$sRet = StringTrimRight($sRet, 1)

			; remove leading zeros from start of string
			$sRet = StringRegExpReplace($sRet, "^[0" & _AutCode_EscapeDelimiters($sRetThoDelim) & "]+", "")

			; spanish doesn't use delims until the 10s of thousands
			If StringLen($sRet) < 6 Then
				$sRet = StringReplace($sRet, $sRetThoDelim, "", 1)
			EndIf
	EndSwitch

	; remove leading zeros from start of string
	$sRet = StringRegExpReplace($sRet, "^[0" & _AutCode_EscapeDelimiters($sRetThoDelim) & "]+", "")

	For $i = 0 To UBound($aDec) - 1
		$sDec &= $aDec[$i]
	Next
	$sDec = StringRegExpReplace($sDec, "^[0" & _AutCode_EscapeDelimiters($sRetDecDelim) & "]+", "")
	If StringLen($sDec) > 0 Then $sDec = $sRetDecDelim & $sDec

	Return $sRet & $sDec
EndFunc   ;==>_AutCode_TextToNumber

; this is rough because some of the spanish numbers I reverted to english
;  for an easier translation method for me
; so english will be the first checked
Func _AutCode_TextNumberGetLanguage($sData, $sFindThou = "", $sFindDec = "")

	; if you can't figure out the error, then it's more than likely a delimiter
	;  you didn't pass and it was being used as a text number value and failed
	; most likely this would happen in the decimal section

	Local Const $aLanguages[] = ["English","Spanish"]
	Local $sRet = ""

	For $i = 0 To UBound($aLanguages) - 1
		$sRet = _AutCode_TextToNumber($sData, $sFindThou, $sFindDec, $i)
		If Not @error And StringLen($sRet) > 0 Then Return $aLanguages[$i]
	Next

	Return SetError(1, 0, "Unknown")
EndFunc

Func _AutCode_EscapeDelimiters($sData)
	Return StringRegExpReplace($sData, "([\\\.\^\$\|\[|\]\(\)\{\}\*\+\?\#])", "\\$1")
EndFunc   ;==>_AutCode_EscapeDelimiters

Func __autcode_getGroupNameFromMilSpanish($sData)

	Local Const $aGroups[] = ["sextillion", "quintillion", "quadrillion", "trillion", "billion", "million"]

	Local Const $sFind = "mil "

	Local Const $iFindLen = StringLen($sFind)

	$sData &= " " ; padding space just in case mil is at the end
	Local $iFind = StringInStr($sData, $sFind, 0, 1)
	If $iFind = 0 Then
		Return SetError(1, 0, "")
	EndIf

	Local $sStart = StringLeft($sData, $iFind - 1)
	Local $sEnd = StringTrimLeft($sData, ($iFind + $iFindLen) - 1)

	Local $sFound = ""
	For $i = 1 To UBound($aGroups) - 1
		If StringInStr($sEnd, $aGroups[$i], 0, 1) Then
			$sFound = $aGroups[$i - 1]
			ExitLoop
		EndIf
	Next

	If $sFound = "" Then
		; we found the last mil
		$sFound = "thousand"
	EndIf

	Return $sStart & $sFound & " " & $sEnd
EndFunc   ;==>__autcode_getGroupNameFromMilSpanish

Func __autcode_textToNumberGetArraySpanish($sData)

	Local Const $aSextillionReplace[] = ["mil trillones", "mil trillónes", "mil trillón", _
			"mil trillon", "cuatrillónes", "cuatrillones", "cuatrillón", "cuatrillon"]
	Local Const $aQuintillionReplace[] = ["trillones", "trillónes", "trillón", "trillon"]
	Local Const $aQuadrillion[] = ["mil billones", "mil billónes", "mil billón", "mil billon"]
	Local Const $aTrillion[] = ["billones", "billónes", "billón", "billon"]
	Local Const $aBillion[] = ["mil millones", "mil millónes", "mil millón", "mil millon", "millardo"]
	Local Const $aMillion[] = ["millones", "millónes", "millón", "millon"]
	Local Const $a500[] = ["quinientos"] ; replace with cinco cientos<sp> (before hundred replaces)
	Local Const $a900[] = ["novecientos"] ; replace with nueve cientos<sp> (before hundred replaces)
	Local Const $aHundred[] = ["cientos"]
	Local Const $a100[] = ["ciento", "cien"]
	Local Const $aTwenty[] = ["veinti"]
	Local Const $aSix[] = ["seis"]
	Local Const $aThree[] = ["trés"]
	Local Const $aOne[] = ["unó ", "una ", "un ", "ún "]
	Local Const $a_Y_[] = [" y "] ; replace with empty string
	Local Const $a20[] = ["viente"]
	Local Const $a30[] = ["treinta"]
	Local Const $a40[] = ["cuarenta"]
	Local Const $a50[] = ["cincuenta"]
	Local Const $a60[] = ["sesenta"]
	Local Const $a70[] = ["setenta"]
	Local Const $a80[] = ["ochenta"]
	Local Const $a90[] = ["noventa"]

	Local Const $aReplace[][] = [ _
			[$aSextillionReplace, " sextillion "], [$aQuintillionReplace, " quintillion "], _
			[$aQuadrillion, " quadrillion "], [$aTrillion, " trillion "], [$aBillion, " billion "], _
			[$aMillion, " million "], [$a500, " cinco cientos "], [$a900, " nueve cientos "], _
			[$aTwenty, " veinte "], [$aSix, " seis "], [$aThree, " tres "], [$aOne, " uno "], _
			[$aHundred, " hundred "], [$a100, " one hundred "], [$a_Y_, ""], [$a20, "viente "], _
			[$a30, " treinta "], [$a40, " cuarenta "], [$a50, " cincuenta "], [$a60, " sesenta "], _
			[$a70, " setenta "], [$a80, " ochenta "], [$a90, " noventa "]]

	Local $sRep = $sData, $aTmp

	For $i = 0 To UBound($aReplace) - 1
		$aTmp = $aReplace[$i][0]
		For $n = 0 To UBound($aTmp) - 1
			$sRep = StringReplace($sRep, $aTmp[$n], $aReplace[$i][1])
		Next
	Next

	$sRep = StringRegExpReplace($sRep, "^\h+|(\h)\h+|\h+$", "$1")

	; now replace the alone mil/thousands from the remainder string
	Local $sHold, $sTmp = $sRep
	While 1
		$sTmp = __autcode_getGroupNameFromMilSpanish($sTmp)
		If @error Then ExitLoop
		$sHold = $sTmp
	WEnd
	If StringLen($sHold) > 0 Then $sRep = $sHold

	Local Const $aGroups[] = ["sextillion", "quintillion", "quadrillion", "trillion", _
			"billion", "million", "thousand"]

	Local $aGStr[UBound($aGroups) + 1]

	$sTmp = $sRep
	Local $iFindLen = 0
	Local $iFind = 0
	For $i = 0 To UBound($aGroups) - 1
		$iFindLen = StringLen($aGroups[$i])
		$iFind = StringInStr($sTmp, $aGroups[$i], 0, 1)
		If $iFind = 0 Then
			$aGStr[$i] = "000"
			ContinueLoop
		EndIf
		$aGStr[$i] = StringRegExpReplace( _
				StringLeft($sTmp, $iFind - 1), "^\h*|\h*$", "")
		$sTmp = StringTrimLeft($sTmp, ($iFindLen + $iFind - 1))
		$sTmp = StringRegExpReplace($sTmp, "^\h*|\h*$", "")
	Next
	$aGStr[UBound($aGStr) - 1] = $sTmp
	Local $aRep = $aGStr
	Local $iRetVal = 0, $iUB

	For $i = 0 To UBound($aGStr) - 1
		If $aGStr[$i] = "000" Then ContinueLoop
		$aTmp = StringRegExp($aGStr[$i], "(\w{2,}(?:\h*hundred)?)", 3)
		$iUB = UBound($aTmp)
		For $n = 0 To $iUB - 1
			$iRetVal = __autcode_textToNumberEvalSpanish( _
					StringRegExpReplace($aTmp[$n], "^\h*|\h*$", ""))
			If @error Then
				; out of scope
				Return SetError(1, $i, 0)
			EndIf
			$aRep[$i] += $iRetVal
		Next
		$aRep[$i] = StringFormat("%03i", $aRep[$i])
	Next

	Return $aRep
EndFunc   ;==>__autcode_textToNumberGetArraySpanish

Func _autcode_textToNumberGetArrayEnglish($sData)

	; fix string with hyphens, fix teen incase some random hyphen was there as well
	$sData = StringReplace(StringReplace($sData, "-", " "), " teen", "teen")

	; ["sextillion","quintillion","quadrillion","trillion","billion","million","thousand","hundred"]
	; going to strip hundred column to make this easier
	Local Const $aGroup[] = ["sextillion", "quintillion", "quadrillion", "trillion", "billion", "million", "thousand"]
	Local $sRE, $sTmp, $sRet
	Local $iEnum = 0

	For $i = 0 To UBound($aGroup) - 1

		$sRE = "(?i)^(.+?" & $aGroup[$i] & ").*$"
		$sTmp = StringRegExpReplace($sData, $sRE, "$1")
		If @extended Then
			$iEnum += 1
			$sRet &= $sTmp & @LF
			; get rid of junk
			$sData = StringRegExpReplace(StringTrimLeft($sData, StringLen($sTmp)), "^\W+", "")
		Else
			$sRet &= $aGroup[$i] & @LF
		EndIf
	Next
	If StringLen($sData) Then
		$iEnum += 1
		$sData = StringRegExpReplace($sData, "^\W+|\h*$", "")
		$sRet &= $sData & @LF
	EndIf

	If $iEnum = 0 Then
		Return SetError(1, 0, 0)
	EndIf

	$sRet = StringTrimRight($sRet, 1)
	Local $aTmp = StringSplit($sRet, @LF, $STR_NOCOUNT)
	Local $iRetUB = UBound($aGroup) + 1
	Local $iTmpUB = UBound($aTmp)
	Local $aRet[$iRetUB]

	; pad array
	For $i = 0 To $iRetUB - 1
		$aRet[$i] = "000"
	Next

	; now strip their group value
	For $i = 0 To UBound($aGroup) - 1
		If ($i > ($iTmpUB - 1)) Then ExitLoop
		If $aTmp[$i] = $aGroup[$i] Then
			$aTmp[$i] = "000"
		Else
			$aTmp[$i] = StringRegExpReplace($aTmp[$i], "\h+" & $aGroup[$i] & "\h*$", "")
		EndIf
	Next

	Local Const $sNumsRE = "(?i)(\w+\h+hundred|\w+)"
	Local $aNums, $iNumUB
	For $i = 0 To $iTmpUB - 1
		If $aTmp[$i] = "000" Then
			$aRet[$i] = "000"
		Else
			$aNums = StringRegExp($aTmp[$i], $sNumsRE, $STR_REGEXPARRAYGLOBALMATCH)
			$iNumUB = UBound($aNums)
			If $iNumUB > 0 Then
				For $n = 0 To $iNumUB - 1
					$aRet[$i] += __autcode_textToNumberEvalEnglish($aNums[$n])
				Next
				; make sure we have 3 chars per block
				If $aRet[$i] < 100 Then
					$aRet[$i] = StringFormat("%03i", $aRet[$i])
				EndIf
			EndIf
		EndIf
	Next

	Return $aRet
EndFunc   ;==>_autcode_textToNumberGetArrayEnglish

Func __autcode_textToNumberEvalSpanish($sData)
	Switch $sData
		Case "cero"
			Return 0
		Case "uno"
			Return 1
		Case "dos"
			Return 2
		Case "tres"
			Return 3
		Case "cuatro"
			Return 4
		Case "cinco"
			Return 5
		Case "seis"
			Return 6
		Case "siete"
			Return 7
		Case "ocho"
			Return 8
		Case "nueve"
			Return 9
		Case "diez"
			Return 10
		Case "once"
			Return 11
		Case "doce"
			Return 12
		Case "trece"
			Return 13
		Case "catorce"
			Return 14
		Case "quince"
			Return 15
		Case "dieciséis", "dieciseis"
			Return 16
		Case "diecisiete"
			Return 17
		Case "dieciocho"
			Return 18
		Case "diecinueve"
			Return 19
		Case "veinte", "viente"
			Return 20
		Case "treinta"
			Return 30
		Case "cuarenta"
			Return 40
		Case "cincuenta"
			Return 50
		Case "sesenta"
			Return 60
		Case "setenta"
			Return 70
		Case "ochenta"
			Return 80
		Case "noventa"
			Return 90
		Case "uno hundred", "one hundred", "cien"
			Return 100
		Case "dos hundred"
			Return 200
		Case "tres hundred"
			Return 300
		Case "cuatro hundred"
			Return 400
		Case "quinientos", "cinco hundred"
			Return 500
		Case "seis hundred"
			Return 600
		Case "siete hundred", "sete hundred"
			Return 700
		Case "ocho hundred"
			Return 800
		Case "novecientos", "nueve hundred"
			Return 900
		Case Else
			Return SetError(1, 0, "")
	EndSwitch
EndFunc   ;==>__autcode_textToNumberEvalSpanish

Func __autcode_textToNumberEvalEnglish($sData)
	Switch $sData
		Case "zero"
			Return 0
		Case "one"
			Return 1
		Case "two"
			Return 2
		Case "three"
			Return 3
		Case "four"
			Return 4
		Case "five"
			Return 5
		Case "six"
			Return 6
		Case "seven"
			Return 7
		Case "eight"
			Return 8
		Case "nine"
			Return 9
		Case "ten"
			Return 10
		Case "eleven"
			Return 11
		Case "twelve"
			Return 12
		Case "thirteen"
			Return 13
		Case "fourteen"
			Return 14
		Case "fifteen"
			Return 15
		Case "sixteen"
			Return 16
		Case "seventeen"
			Return 17
		Case "eighteen"
			Return 18
		Case "nineteen"
			Return 19
		Case "twenty"
			Return 20
		Case "thirty"
			Return 30
		Case "forty"
			Return 40
		Case "fifty"
			Return 50
		Case "sixty"
			Return 60
		Case "seventy"
			Return 70
		Case "eighty"
			Return 80
		Case "ninety"
			Return 90
		Case "one hundred"
			Return 100
		Case "two hundred"
			Return 200
		Case "three hundred"
			Return 300
		Case "four hundred"
			Return 400
		Case "five hundred"
			Return 500
		Case "six hundred"
			Return 600
		Case "seven hundred"
			Return 700
		Case "eight hundred"
			Return 800
		Case "nine hundred"
			Return 900
		Case Else
			Return SetError(1, 0, "")
	EndSwitch
EndFunc   ;==>__autcode_textToNumberEvalEnglish

Func __autcode_numberToText($aInt, $sDelim = "", $iLang = 0, $bReturnNumTypeUB = False)

	Switch $iLang
		Case $N2T_LANGENGLISH
			Return __autcode_numberToText_LibEnglish($aInt, $sDelim, $bReturnNumTypeUB)
		Case $N2T_LANGSPANISH
			Return __autcode_numberToText_LibSpanish($aInt, $sDelim, $bReturnNumTypeUB)
		Case Else
			Return SetError(-1, $iLang, "")
	EndSwitch

EndFunc   ;==>__autcode_numberToText

Func __autcode_numberToText_LangArray($iType, $iLang = 0)

	Local $iMaxLangs = 2
	Local $iMaxDims = 5

	If (($iType < 0) Or ($iType > $iMaxDims)) Then
		Return SetError(1, 0, 0)
	EndIf

	If ($iLang < 0) Or ($iLang > ($iMaxLangs - 1)) Then
		Return SetError(2, 0, 0)
	EndIf

	; 0 = english
	; 1 = spanish
	Local Const $sGNEnglish = "|thousand|million|billion|trillion|quadrillion|quintillion|sextillion"
	Local Const $sGNSpanish = "|mil|millones|mil millones|billones|mil billones|trillones|mil trillones"

	Local Const $aGNEnglish = StringSplit($sGNEnglish, "|", $STR_NOCOUNT)
	Local Const $aGNSpanish = StringSplit($sGNSpanish, "|", $STR_NOCOUNT)

	Local Const $s0___9English = "zero|one|two|three|four|five|six|seven|eight|nine"
	Local Const $s0___9Spanish = "cero|uno|dos|tres|cuatro|cinco|seis|siete|ocho|nueve"
	Local Const $a0___9English = StringSplit($s0___9English, "|", $STR_NOCOUNT)
	Local Const $a0___9Spanish = StringSplit($s0___9Spanish, "|", $STR_NOCOUNT)

	Local Const $s10_19English = "||||||||||ten|eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen"
	Local Const $s10_19Spanish = "||||||||||diez|once|doce|trece|catorce|quince|dieciséis|diecisiete|dieciocho|diecinueve"
	Local Const $a10_19English = StringSplit($s10_19English, "|", $STR_NOCOUNT)
	Local Const $a10_19Spanish = StringSplit($s10_19Spanish, "|", $STR_NOCOUNT)

	Local Const $s20_90English = "||twenty|thirty|forty|fifty|sixty|seventy|eighty|ninety"
	Local Const $s20_90Spanish = "||veinte|treinta|cuarenta|cincuenta|sesenta|setenta|ochenta|noventa"
	Local Const $a20_90English = StringSplit($s20_90English, "|", $STR_NOCOUNT)
	Local Const $a20_90Spanish = StringSplit($s20_90Spanish, "|", $STR_NOCOUNT)

	Local Const $s__100English = "|one hundred|two hundred|three hundred|four hundred|five hundred|" & _
			"six hundred|seven hundred|eight hundred|nine hundred"
	Local Const $s__100Spanish = "|ciento|doscientos|trescientos|cuatrocientos|quinientos|seiscientos|" & _
			"setecientos|ochocientos|novecientos"
	Local Const $a__100English = StringSplit($s__100English, "|", $STR_NOCOUNT)
	Local Const $a__100Spanish = StringSplit($s__100Spanish, "|", $STR_NOCOUNT)

	Local Const $aGroupRet[$iMaxDims + 1][$iMaxLangs] = [ _
			[$aGNEnglish, $aGNSpanish], _
			[$a0___9English, $a0___9Spanish], _
			[$a10_19English, $a10_19Spanish], _
			[$a20_90English, $a20_90Spanish], _
			[$a__100English, $a__100Spanish] _
			]

	Return $aGroupRet[$iType][$iLang]
EndFunc   ;==>__autcode_numberToText_LangArray

Func __autcode_numberToText_LibEnglish($aInt, $sDelim = "", $bReturnNumTypeUB = False)

	; # Defaults Start ============================================================================================

	Local Enum $iGNumber, $i0_9, $i10_19, $i20_90, $i100

	Local Const $sEnglish0_100 = _
			"zero,one,two,three,four,five,six,seven,eight,nine,ten,eleven,twelve,thirteen," & _
			"fourteen,fifteen,sixteen,seventeen,eighteen,nineteen,twenty,twenty one," & _
			"twenty two,twenty three,twenty four,twenty five,twenty six,twenty seven," & _
			"twenty eight,twenty nine,thirty,thirty one,thirty two,thirty three," & _
			"thirty four,thirty five,thirty six,thirty seven,thirty eight,thirty nine," & _
			"forty,forty one,forty two,forty three,forty four,forty five,forty six," & _
			"forty seven,forty eight,forty nine,fifty,fifty one,fifty two,fifty three," & _
			"fifty four,fifty five,fifty six,fifty seven,fifty eight,fifty nine," & _
			"sixty,sixty one,sixty two,sixty three,sixty four,sixty five,sixty six," & _
			"sixty seven,sixty eight,sixty nine,seventy,seventy one,seventy two," & _
			"seventy three,seventy four,seventy five,seventy six,seventy seven," & _
			"seventy eight,seventy nine,eighty,eighty one,eighty two,eighty three," & _
			"eighty four,eighty five,eighty six,eighty seven,eighty eight,eighty nine," & _
			"ninety,ninety one,ninety two,ninety three,ninety four,ninety five," & _
			"ninety six,ninety seven,ninety eight,ninety nine,one hundred"

	Local Const $a0_100English = StringSplit($sEnglish0_100, ",", $STR_NOCOUNT)

	Local Const $aNumType = __autcode_numberToText_LangArray($iGNumber, $N2T_LANGENGLISH)
	Local Const $a100English = __autcode_numberToText_LangArray($i100, $N2T_LANGENGLISH)

	; # Defaults End ==============================================================================================
	Local $iNumUB = UBound($aNumType)

	If $bReturnNumTypeUB Then
		Return $iNumUB
	EndIf

	Local $aTmp, $sRet, $sTmp
	Local $iLen = 0, $iInt = 0
	Local $iUB = UBound($aInt)
	Local $iNum = 0

	If $iUB > UBound($aNumType) Then
		Return SetError(1, 0, "")
	EndIf

	; garbage, whole array being passed
	For $i = 0 To $iUB - 1

		$iLen = StringLen($sRet)
		$iInt = Int($aInt[$i])
		$sTmp = ""

		If $i < ($iUB - 1) And $iInt = 0 Then ContinueLoop
		If $i = ($iUB - 1) And $iInt = 0 And $iLen > 0 Then ContinueLoop

		Switch $iInt
			Case 0 To 100
				$sTmp = $a0_100English[$iInt]
			Case Else ; 101-999 - which means it is 3 ubound, no loop=
				$aTmp = StringRegExp($aInt[$i], "\d", $STR_REGEXPARRAYGLOBALMATCH)
				$sTmp = $a100English[Int($aTmp[0])] & " " ; 1-9 * 100
				$iNum = (Int($aTmp[1]) * 10) + Int($aTmp[2])
				If $iNum > 0 Then
					$sTmp &= $a0_100English[$iNum]
				EndIf
		EndSwitch

		; now we concat
		If $i < ($iUB - 1) Then
			$sTmp = $sTmp & " " & $aNumType[(($iUB - 1) - $i)] & $sDelim & " "
		Else
			If ($iUB - 1) > 0 Then
				$sTmp = $sTmp & " " & $aNumType[(($iUB - 1) - $i)]
			EndIf
		EndIf

		$sRet &= $sTmp
	Next
;~ #cs
	; ## CLEANUP START ============================================================================================

	; ## CLEANUP END ==============================================================================================
;~ #ce
	Return StringStripWS($sRet, $STR_STRIPTRAILING)
EndFunc   ;==>__autcode_numberToText_LibEnglish

Func __autcode_numberToText_LibSpanish($aInt, $sDelim = "", $bReturnNumTypeUB = False)

	; # Defaults Start ============================================================================================

	Local Enum $iGNumber, $i0_9, $i10_19, $i20_90, $i100

	Local Const $sSpanish0_100 = _
			"cero,uno,dos,tres,cuatro,cinco,seis,siete,ocho,nueve,diez,once,doce,trece,catorce," & _
			"quince,dieciséis,diecisiete,dieciocho,diecinueve,veinte,veintiuno,veintidós," & _
			"veintitrés,veinticuatro,veinticinco,veintiséis,veintisiete,veintiocho," & _
			"veintinueve,treinta,treinta y uno,treinta y dos,treinta y tres,treinta y cuatro," & _
			"treinta y cinco,treinta y seis,treinta y siete,treinta y ocho,treinta y nueve," & _
			"cuarenta,cuarenta y uno,cuarenta y dos,cuarenta y tres,cuarenta y cuatro," & _
			"cuarenta y cinco,cuarenta y seis,cuarenta y siete,cuarenta y ocho,cuarenta y nueve," & _
			"cincuenta,cincuenta y uno,cincuenta y dos,cincuenta y tres,cincuenta y cuatro," & _
			"cincuenta y cinco,cincuenta y seis,cincuenta y siete,cincuenta y ocho," & _
			"cincuenta y nueve,sesenta,sesenta y uno,sesenta y dos,sesenta y tres,sesenta y cuatro," & _
			"sesenta y cinco,sesenta y seis,sesenta y siete,sesenta y ocho,sesenta y nueve," & _
			"setenta,setenta y uno,setenta y dos,setenta y tres,setenta y cuatro,setenta y cinco," & _
			"setenta y seis,setenta y siete,setenta y ocho,setenta y nueve,ochenta," & _
			"ochenta y uno,ochenta y dos,ochenta y tres,ochenta y cuatro,ochenta y cinco," & _
			"ochenta y seis,ochenta y siete,ochenta y ocho,ochenta y nueve,noventa," & _
			"noventa y uno,noventa y dos,noventa y tres,noventa y cuatro,noventa y cinco," & _
			"noventa y seis,noventa y siete,noventa y ocho,noventa y nueve,cien"

	Local Const $a0_100Spanish = StringSplit($sSpanish0_100, ",", $STR_NOCOUNT)

	Local Const $aNumType = __autcode_numberToText_LangArray($iGNumber, $N2T_LANGSPANISH)
	Local Const $a100Spanish = __autcode_numberToText_LangArray($i100, $N2T_LANGSPANISH)

	; # Defaults End ==============================================================================================
	Local $iNumUB = UBound($aNumType)

	If $bReturnNumTypeUB Then
		Return $iNumUB
	EndIf

	Local $aTmp, $sRet, $sTmp
	Local $iLen = 0, $iInt = 0
	Local $iUB = UBound($aInt)
	Local $iNum = 0

	; garbage, whole array being passed
	For $i = 0 To $iUB - 1

		$iLen = StringLen($sRet)
		$iInt = Int($aInt[$i])
		$sTmp = ""

		If $i < ($iUB - 1) And $iInt = 0 Then ContinueLoop
		If $i = ($iUB - 1) And $iInt = 0 And $iLen > 0 Then ContinueLoop

		Switch $iInt
			Case 0 To 100
				$sTmp = $a0_100Spanish[$iInt]
			Case Else ; 101-999 - which means it is 3 ubound, no loop=
				$aTmp = StringRegExp($aInt[$i], "\d", $STR_REGEXPARRAYGLOBALMATCH)
				$sTmp = $a100Spanish[Int($aTmp[0])] & " " ; 1-9 * 100
				$iNum = (Int($aTmp[1]) * 10) + Int($aTmp[2])
				If $iNum > 0 Then
					$sTmp &= $a0_100Spanish[$iNum]
				EndIf
		EndSwitch

		; now we concat
		If $i < ($iUB - 1) Then
			; catch uno mil for thousands / translate to mil
			If (((($iUB - 1) - $i) = 1) And ($sTmp = "uno")) Then
				$sTmp = $aNumType[(($iUB - 1) - $i)] & $sDelim & " "
			Else
				$sTmp = $sTmp & " " & $aNumType[(($iUB - 1) - $i)] & $sDelim & " "
			EndIf
		Else
			If ($iUB - 1) > 0 Then
				$sTmp = $sTmp & " " & $aNumType[(($iUB - 1) - $i)]
			EndIf
		EndIf

		$sRet &= $sTmp
	Next
;~ #cs
	; ## CLEANUP START ============================================================================================
	Local Const $aIllones[3] = ["millones", "billones", "trillones"]

	For $i = 0 To UBound($aIllones) - 1
		If StringInStr($sRet, $aIllones[$i], 0, 2) Then
			If StringInStr($sRet, $aIllones[$i], 0, 2) Then
				$sRet = StringReplace($sRet, " mil " & $aIllones[$i], " mil")
			EndIf
			If StringRegExp($sRet, "(?<!\w)uno\h+") Then
				$sRet = StringReplace($sRet, "uno " & $aIllones[$i], "un " & $aIllones[$i])
				$sRet = StringRegExpReplace($sRet, "(?i)(?<!\w)uno mil(\W|$)", "un mil$1")
			EndIf
		ElseIf StringInStr($sRet, "uno " & $aIllones[$i], 0, 1) Then
			$sRet = StringReplace($sRet, "uno " & $aIllones[$i], "un " & StringTrimRight($aIllones[$i], 2))
		EndIf
	Next
	; catch remaining un mil for thousands or leading repeat / translate to mil
	; changed 02/26/2024 added (?<!\hy\h) to catch the y before un
	$sRet = StringRegExpReplace($sRet, "(^|\W*)(?<!\hy\h)un(\h+mil\W)", "$1$2")

	; now for singular correct accent values ... ugh
	$sRet = StringRegExpReplace($sRet, "((?:m|b|tr)ill)(o)(n(?:\W|$))", "$1ó$3")
	; ## CLEANUP END ==============================================================================================
;~ #ce
	Return StringStripWS($sRet, $STR_STRIPTRAILING)
EndFunc   ;==>__autcode_numberToText_LibSpanish
