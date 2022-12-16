#cs ----------------------------------------------------------------------------

	Example script for Advanced Math UDF
	PROBABILITY

#ce ----------------------------------------------------------------------------

#include "..\Math.au3"

; 1. Calculate the probability of flipping heads with a coin
Global $Events1 = [CoinFlip()]
Global $Expected1 = ["H"] ; H - heads, T - tails
Global $vResult1 = CalculateProbability($Events1, $Expected1)
ConsoleWrite("Probability (1) = " & $vResult1 & @CRLF)

; 2. Calculate the probability of flipping heads with a coin AND rolling 4 with a die
Global $Events2 = [CoinFlip(), DieRoll()]
Global $Expected2 = ["H", 4]
Global $vResult2 = CalculateProbability($Events2, $Expected2)
ConsoleWrite("Probability (2) = " & $vResult2 & @CRLF)

; 3. Calculate the probability of rolling 7 with a die
Global $Events3 = [DieRoll()]
Global $Expected3 = [7]
Global $vResult3 = CalculateProbability($Events3, $Expected3)
ConsoleWrite("Probability (3) = " & $vResult3 & @CRLF)

; 4. Calculate the probability of rolling 1 OR 4 with a die
Global $Events4 = [DieRoll()]
Global $Rolls = [1, 4]
Global $Expected4 = [$Rolls]
Global $vResult4 = CalculateProbability($Events4, $Expected4)
ConsoleWrite("Probability (4) = " & $vResult4 & @CRLF)

; 5. Calculate the probability of a custom event
Global $Event = [65, 32, 35, 87]
Global $Events5 = [$Event]
Global $Expected5 = [87]
Global $vResult5 = CalculateProbability($Events5, $Expected5)
ConsoleWrite("Probability (5) = " & $vResult5 & @CRLF)

; 6. Calculate the probability of a custom event (Procedural)
Global $Events6 = [MyEvent]
Global $Expected6 = [4]
Global $vResult6

For $iSamples = 10 To 100 Step +10
	$vResult6 = CalculateProbability($Events6, $Expected6, False, $iSamples)
	ConsoleWrite("Probability (6) for " & $iSamples & " samples = " & $vResult6 & @CRLF)
Next

Func MyEvent()
	Return Random(1, 10, 1)
EndFunc