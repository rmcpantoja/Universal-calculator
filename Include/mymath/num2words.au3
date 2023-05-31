#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include-once
Global $nNumber, $bIncludeAnd, $sNumber
MsgBox(0, "Result", NumberToWords(23456, False))
Func NumberToWords($nNumber, $bIncludeAnd = True)
	Local $aOnes = StringSplit("cero,uno,dos,tres,cuatro,cinco,seis,siete,ocho,nueve", ",")
	local $aTildes = StringSplit("dós,trés,cuatro,cinco,séis,siete,ocho,nueve", ",")
	Local $aTeens = StringSplit("diez,once,doce,trece,catorce,quince,dieciseis,diecisiete,dieciocho,diecinueve", ",")
	Local $aTens = StringSplit("dieci,veinte,treinta,cuarenta,cincuenta,sesenta,setenta,ochenta,noventa", ",")
	Local $aHundreds = StringSplit("cien,doscientos,trescientos,cuatrocientos,quinientos,seiscientos,setecientos,ochocientos,novecientos", ",")
	local $bTilde
	Local $sNumber = ""
	If $nNumber = 0 Then
		$sNumber = "cero"
	ElseIf $nNumber < 0 Then
		$sNumber = "menos " & NumberToWords(Abs($nNumber), $bIncludeAnd)
	Else
		If $nNumber >= 1000000 Then
			$sNumber = NumberToWords(int($nNumber / 1000000), $bIncludeAnd) & " millones "
			If $bIncludeAnd And mod($nNumber, 1000000) Then $sNumber &= "y "
			$nNumber = mod($nNumber, 1000000)
		EndIf
		switch $nNumber
			case 1 to 1999 ; para evitar que convierta "uno mil xxx"
				if StringLen($nNumber) = 4 and StringLeft($nNumber, 1) = 1 then $sNumber &= "mil "
			case 2000 to 999999
				$sNumber &= NumberToWords(Int($nNumber / 1000), $bIncludeAnd) & " mil "
		EndSwitch
		If $bIncludeAnd And mod($nNumber, 1000) Then $sNumber &= "y "
		$nNumber = mod($nNumber, 1000)
		switch $nNumber
			$bTilde = False
			case 100 ; número propio.
				$sNumber &= "cien "
			case 101 to 199 ; aquí se tendrá que convertir ciento.
				$sNumber &= "ciento "
			case 200 to 999 ; aquí doscientos, trescientos, cuatrocientos, etc.
				$sNumber &= $aHundreds[Int($nNumber / 100)] & " "
		EndSwitch
		$nNumber = mod($nNumber, 100)
		If $nNumber >= 20 Then
			if StringRight($nNumber, 1) >= 1 then
				If not StringLeft($nNumber, 1) = 2 then
					$bTilde = False
					$sNumber &= $aTens[Int($nNumber / 10)] & " y "
				Else
					$sNumber &= "veinti"
					$bTilde = True
				EndIf
			Else
				$sNumber &= $aTens[Int($nNumber / 10)] & " "
			EndIf
			$nNumber = mod($nNumber, 10)
		ElseIf $nNumber >= 10 Then
			$sNumber &= $aTeens[$nNumber - 9] & " "
			;$nNumber = StringRight($nNumber, 1)
			$nNumber = 0
		EndIf
		If $nNumber > 2 Then
			if $bTilde then
				$bTilde = False
				$sNumber &= $aTildes[$nNumber-1] & " "
			Else
				$sNumber &= $aOnes[$nNumber+1] & " "
			EndIf
		EndIf
	EndIf
	Return StringStripWS($sNumber, $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)
EndFunc