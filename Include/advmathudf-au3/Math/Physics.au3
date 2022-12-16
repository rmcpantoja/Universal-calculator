#include-once

#Region Special Relativity

Func LorentzFactor($Velocity)
	Return 1/Sqrt(1-($Velocity^2)/($SpeedOfLight^2))
EndFunc

Func TimeDilation($Time0, $Velocity)
	Return $Time0*LorentzFactor($Velocity)
EndFunc

Func LengthContraction($Length0, $Velocity)
	Return $Length0/LorentzFactor($Velocity)
EndFunc

Func RelativisticMomentum($Mass, $Velocity)
	Return $Mass*$Velocity*LorentzFactor($Velocity)
EndFunc

#EndRegion

#Region Classical Mechanics

Func NewtonianGravity($vec1, $mass1, $vec2, $mass2)
	Local $Dist = VectorDistance($vec1, $vec2)
	Local $Dir = VectorNormalize(VectorSubtract($vec2, $vec1))

	Return VectorMultiplyScalar($Dir, -$NewtonGravConstant*(($mass1*$mass2)/($Dist^2)))
EndFunc

Func FallTime($fHeight, $fAcceleration = 9.81)
	Return Sqrt(2*$fHeight/$fAcceleration)
EndFunc

#EndRegion