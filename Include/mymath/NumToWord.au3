
Func NumFromWord($sWord)
	Local $sDigits = "zero|one|two|three|four|five|six|seven|eight|nine"
	Local $sTeens = "eleven|twelve|thirteen|fourteen|fifteen|sixteen|seventeen|eighteen|nineteen"
	Local $sTens = "ten|twenty|thirty|forty|fifty|sixty|seventy|eighty|ninety"
	Local $sBig = "thousand|million|billion|trillion|quadrillion|quintillion|sextillion|septillion|octillion|nonillion|" & _
			"decillion|undecillion|duodecillion|tredecillion|quattuordecillion|quindecillion|sexdecillion|septendecillion|octodecillion|novemdecillion|vigintillion"

	Local $asDigits = StringSplit($sDigits, "|", 2)
	Local $asTeens = StringSplit($sTeens, "|", 2)
	Local $asTens = StringSplit($sTens, "|", 2)
	Local $asBig = StringSplit($sBig, "|", 2)

	Local $sRet = ""
	Local $iTemp[3] = [0, 0, 0]
	Local $aWords

	; check...
	If Not StringRegExp($sWord, "^(minus\s+)?((((" & $sTens & ")\s+)?(" & $sDigits & ")|(" & $sTeens & ")|(" & $sTens & "))\s+(hundred|" & $sBig & ")(\s+and)?(\s+|\z))*(((" & $sTens & ")\s+)?(" & $sDigits & ")?|(" & $sTeens & ")|(" & $sTens & "))(\s+point(\s+(" & $sDigits & "))+)?$") Then _
			Return SetError(1)

	$sWord = StringReplace($sWord, " and", "")
	For $i = 0 To 8
		$sWord = StringReplace($sWord, $asTeens[$i], "ten " & $asDigits[$i + 1])
	Next

	$aWords = StringSplit($sWord, " ")

	If StringInStr($sWord, " point ") Then
		Do
			For $n = 0 To UBound($asDigits) - 1
				If $asDigits[$n] = $aWords[$aWords[0]] Then
					$sRet = $n & $sRet
					ExitLoop
				EndIf
			Next

			$aWords[0] -= 1
		Until $aWords[$aWords[0]] <> "point"
		$sRet = "." & $sRet

		If $aWords[$aWords[0]] = "zero" Then $sRet = "0" & $sRet
	EndIf

	For $i = $aWords[0] To 1 Step -1
		If $i = 1 And $aWords[1] = "minus" Then
			$sRet = "-" & $sRet
			ExitLoop
		EndIf

		If StringInStr("|" & $sDigits & "|", "|" & $aWords[$i] & "|") Then ; Digit
			If $iTemp[0] <> 0 Then Return SetError(2, $i, "") ; Invalid word: @extended, expected large identifier not digit.

			For $n = 0 To UBound($asDigits) - 1
				If $asDigits[$n] = $aWords[$i] Then
					$iTemp[0] = $n
					ExitLoop
				EndIf
			Next
		ElseIf StringInStr("|" & $sTens & "|", "|" & $aWords[$i] & "|") Then ; Tens
			If $iTemp[1] <> 0 Then Return SetError(3, $i, "") ; Invalid word: @extended, expected large identifier not ten.

			For $n = 0 To UBound($asTens) - 1
				If $asTens[$n] = $aWords[$i] Then
					$iTemp[1] = $n + 1
					ExitLoop
				EndIf
			Next
		ElseIf $aWords[$i] = "hundred" Then ; hundred
			If $iTemp[2] <> 0 Then Return SetError(4, $i, "") ; Invalid word: @extended, expected large identifier not hundred.

			For $n = 0 To UBound($asDigits) - 1
				If $asDigits[$n] = $aWords[$i - 1] Then
					$iTemp[2] = $n
					$i -= 1
					ExitLoop
				EndIf
			Next
		ElseIf StringInStr("|" & $sBig & "|", "|" & $aWords[$i] & "|") Then ; BIG
			$sRet = $iTemp[2] & $iTemp[1] & $iTemp[0] & $sRet

			$iTemp[0] = 0
			$iTemp[1] = 0
			$iTemp[2] = 0
		Else
			Return SetError(4, $i, "") ; Invalid word: @extended, word not recognized.
		EndIf
	Next
	$sRet = $iTemp[2] & $iTemp[1] & $iTemp[0] & $sRet

	; No leading 0's
	While StringLeft($sRet, 1) = "0" And StringLeft($sRet, 2) <> "0."
		$sRet = StringTrimLeft($sRet, 1)
	WEnd

	; No trailing 0's if decimal
	If StringInStr($sRet, ".") Then
		While StringRight($sRet, 1) = "0"
			$sRet = StringTrimRight($sRet, 1)
		WEnd
		If StringRight($sRet, 1) = "." Then $sRet = StringTrimRight($sRet, 1)
	EndIf

	Return $sRet
EndFunc   ;==>NumFromWord

Func NumToWord($iNum)
	$iNum = String($iNum)
	$iNum = StringStripWS($iNum, 8)
	If Not StringRegExp($iNum, "^-?\d+?(\.\d+)?$") Then Return SetError(2, 0, "")
	If $iNum = "0" Then Return "zero"

	Local $asDigits[10] = ["cero", "uno", "dos", "tres", "cuatro", "cinco", "seis", "siete", "ocho", "nueve"]
	Local $asTeens[9] = ["once", "doce", "trece", "catorce", "quince", "dieziseis", "diezisiete", "dieziocho", "diezinueve"]
	Local $asTens[9] = ["diez", "veinte", "treinta", "cuarenta", "cincuenta", "sesenta", "setenta", "ochenta", "noventa"]
	Local $asBig[21] = ["mil", "millones", "billones", "trillones", "cuadrillones", "quintillones", "sextillones", "septillones", "octillones", "novellones", _
			"decillón", "oncellón", "duodecillón", "tredecillón", "cuattuordecillón", "quindecillón", "sexdecillón", "septendecillón", "octodecillón", "novemdecillón", "vigintillón"]


	; No leading 0's
	While StringLeft($iNum, 1) = "0" And StringLeft($iNum, 2) <> "0."
		$iNum = StringTrimLeft($iNum, 1)
	WEnd

	; No trailing 0's if decimal
	If StringInStr($iNum, ".") Then
		While StringRight($iNum, 1) = "0"
			$iNum = StringTrimRight($iNum, 1)
		WEnd
		If StringRight($iNum, 1) = "." Then $iNum = StringTrimRight($iNum, 1)
	EndIf

	Local $iTemp
	Local $iLen
	Local $sRet = ""
	Local $nDec = ""

	; Do decimal places later
	If StringInStr($iNum, ".") Then
		$nDec = StringMid($iNum, StringInStr($iNum, ".") + 1)
		$iNum = StringLeft($iNum, StringInStr($iNum, ".") - 1)
	EndIf

	; Check negative
	If StringLeft($iNum, 1) = "-" Then
		$iNum = StringTrimLeft($iNum, 1)
		$sRet &= "menos "
	EndIf

	; Very big numbers
	For $i = 21 To 1 Step -1
		If StringLen($iNum) > $i * 3 Then
			$iLen = Mod(StringLen($iNum), 3)
			If $iLen = 0 Then $iLen = 3

			$iTemp = StringLeft($iNum, $iLen)
			$iNum = StringTrimLeft($iNum, $iLen)

			$iTemp = NumToWord($iTemp)
			If $iTemp = "" Or $iTemp = "0" Then ContinueLoop
			If Not @error Then $sRet &= $iTemp & " " & $asBig[$i - 1] & " "
		EndIf
	Next

	; hundreds
	If StringLen($iNum) >= 3 Then
		$iTemp = StringLeft($iNum, 1)
		$iNum = StringTrimLeft($iNum, 1)

		If $iTemp <> "0" Then $sRet &= $asDigits[Int($iTemp)] & " ciento"
		If $iNum <> "00" Then $sRet &= " "
	EndIf

	If StringLen($iNum) = 2 And StringLeft($iNum, 1) = "1" And StringRight($iNum, 1) <> "0" Then
		$iTemp = StringRight($iNum, 1)
		$sRet &= $asTeens[Int($iTemp) - 1] & " "

		$iNum = ""
	Else
		; Tens
		If StringLen($iNum) = 2 Then
			$iTemp = StringLeft($iNum, 1)
			$iNum = StringTrimLeft($iNum, 1)

			If $iTemp <> "0" Then $sRet &= $asTens[Int($iTemp) - 1] & " y "
		EndIf

		; Digits
		If StringLen($iNum) = 1 Then
			If $iNum <> "0" Then $sRet &= $asDigits[Int($iNum)] & " "

			$iNum = ""
		EndIf
	EndIf

	If $nDec <> "" Then
		If $sRet = "" Or $sRet = "menos " Then $sRet &= "zero "
		$sRet &= " punto "

		Do
			$iTemp = StringLeft($nDec, 1)
			$nDec = StringTrimLeft($nDec, 1)

			$sRet &= $asDigits[Int($iTemp)] & " "
		Until $nDec = ""
	EndIf

	$sRet = StringTrimRight($sRet, 1)

	Return $sRet
EndFunc   ;==>NumToWord