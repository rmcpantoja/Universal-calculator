#include-once
#include <Array.au3>

#include "Math\Constants.au3"
#include "Math\PhysConstants.au3"
#include "MathConstants.au3"


#include "Math\Chebyshev.au3" ; Used for special function approximations

#include "Math\Boole.au3"
#include "Math\Combinatorics.au3"
#include "Math\Complex.au3"
#include "Math\Curves.au3"
#include "Math\Fractions.au3"
#include "Math\Genetic.au3"
#include "Math\Hyperbolic.au3"
#include "Math\Interpolation.au3"
#include "Math\Logarithms.au3"
#include "Math\Matrices.au3"
#include "Math\MatrixCellwise.au3"
#include "Math\Means.au3"
#include "Math\Misc.au3"
#include "Math\Mollify.au3"
#include "Math\NaturalNumbers.au3"
#include "Math\NumberTheory.au3"
#include "Math\Obsolete.au3"
#include "Math\Physics.au3"
#include "Math\Pochhammer.au3"
#include "Math\Primes.au3"
#include "Math\Probability.au3"
#include "Math\Quaternion.au3"
#include "Math\Roots.au3"
#include "Math\Sequences.au3"
#include "Math\Solve.au3"
#include "Math\SpecialNumbers.au3"
#include "Math\Statistics.au3"
#include "Math\Trigonometric.au3"

#include "Math\Special\Airy.au3"
#include "Math\Special\Anger.au3"
#include "Math\Special\BesselJ.au3"
#include "Math\Special\BesselY.au3"
#include "Math\Special\Erf.au3"
#include "Math\Special\FourierWave.au3"
#include "Math\Special\Fresnel.au3"
#include "Math\Special\Gamma.au3"
#include "Math\Special\Misc.au3"
#include "Math\Special\Step.au3"
#include "Math\Special\TrigIntegrals.au3"
#include "Math\Special\Zeta.au3"

#include "Math\Geometry\Point.au3"
#include "Math\Geometry\Euler.au3"
#include "Math\Geometry\Vector.au3"
#include "Math\Geometry\Triangle.au3"
#include "Math\Geometry\Fractal.au3"

#include "Math\Calculus\Differential.au3"
#include "Math\Calculus\Integral.au3"

#include "Math\Graphs\Graph.au3"
#include "Math\Graphs\Dijkstra.au3"

#include "Math\Random\Random.au3"
#include "Math\Random\LCG.au3"
#include "Math\Random\Xorshift.au3"

; QUADPACK port
#include "Math\QUADPACK\util.au3"
#include "Math\QUADPACK\qng.au3"
#include "Math\QUADPACK\qk.au3"
#include "Math\QUADPACK\qk15.au3"
#include "Math\QUADPACK\qk21.au3"

; #INDEX# =======================================================================================================================
; Title .........: Advanced Math UDF
; UDF Version ...: 1.8.0
; AutoIt Version : 3.3.14.0
; Language ......: English
; Description ...: Advanced mathematical functions.
; Author(s) .....: scintilla4evr
; ===============================================================================================================================

Global $__g_ADVMATHUDF_INTEGRALSTEP = 0.001

; #CURRENT# =====================================================================================================================
; BooleAnd
; BooleOr
; BooleNot
; BooleEqual
; BooleXor
; Combination
; CombinationR
; Variation
; VariationR
; BellCurve
; ParabolaCurve
; CubicCurve
; QuarticCurve
; FoliumCurve
; CissoidCurve
; ConchoidCurve
; SemicubicalParabolaCurve
; SerpentineCurve
; ContinuedFraction
; Cosh
; Coth
; Csch
; Sech
; Sinh
; Tanh
; ACosh
; ACoth
; ACsch
; ASech
; ASinh
; ATanh
; LinearInterpolation
; CosineInterpolation
; CubicInterpolation
; LogN
; Log10
; Log2
; Logit
; ArithmeticMean
; HeinzMean
; LogMean
; HeronianMean
; StolarskyMean
; Sinc
; BernoulliStirling
; Gd
; AGd
; GaussLegendrePi
; BitEqual
; Factor
; Divisors
; GCD
; LCM
; Factorial
; FactorialN
; Superfactorial
; Newton
; Pi
; Tau
; Sigma
; EulerTotient
; Versin
; Exsec
; RisingFactorial
; FallingFactorial
; IsCoprime
; IsPrime
; IsPrime2
; ListPrimes
; ListPrimes2
; NthPrime
; NRoot
; Cbrt
; Stirling1
; Stirling2
; Bell
; Bernoulli
; Catalan
; Carol
; Cullen
; AiryAi
; AiryBi
; BesselJ0
; BesselJ1
; BesselJn
; BesselY0
; BesselY1
; BesselYn
; Erf
; Erfc
; FourierSquareWave
; FourierSawtoothWave
; FourierTriangleWave
; Gamma
; Digamma
; Beta
; Sign
; SawtoothWave
; SquareWave
; TriangleWave
; RiemannZeta
; RiemannXi
; DirichletEta
; HurwitzZeta
; DirichletLambda
; TriangularNum
; HexagonalNum
; Cot
; Sec
; Csc
; ACot
; ASec
; ACsc
;
; ADDED WITH VERSION 1.1:
; Differential
; Point
; RotatePoint
; AngleBetweenPoints
; CoinFlip
; DieRoll
; CalculateProbability
; NormalDistribution
; ArcsineDistribution
; BetaDistribution
; DiracDelta
;
; ADDED WITH VERSION 1.2:
; Determinant
; MultiplyArrayByMatrix
; DistanceBetweenPoints
; Vector
; VectorAdd
; VectorSubtract
; VectorMultiplyScalar
; VectorDivideScalar
; VectorNegate
; VectorApplyOp
; VectorDotProduct
; VectorCross
; VectorLength
; VectorNormalize
; VectorAngleBetween
; VectorReflect
; VectorTransmit
; EulerRotateX
; EulerRotateY
; EulerRotateZ
; Complex
; ComplexReal
; ComplexImag
; ComplexNegate
; ComplexAbs
; ComplexArg
; ComplexConj
; ComplexAdd
; ComplexSubtract
; ComplexMultiply
; ComplexDivide
; ComplexExp
; ComplexLog
; ComplexPow
; Quaternion
; QuaternionGetVector
; QuaternionFromScalarVectorPair
; QuaternionConj
; QuaternionNorm
; QuaternionAdd
; QuaternionSubtract
; QuaternionMultiply
; QuaternionInvert
; QuaternionDivide
; QuaternionRotateVector
;
; ADDED WITH VERSION 1.3:
; PolygonalNum
; NSimplexNum
; Fibonacci
; Lucas
; LucasLehmer
; IsPrimeLucas
; IsMersennePrime
; IsPrime3
; ListPrimes3
; Lychrel
; Integral
; Pascal
; IsPrimeAKS
; IsPrime1
; Differential2
; Limit
; Solve
; IdentityMatrix
; TransposeMatrix
;
; ADDED WITH VERSION 1.3.1:
; Trigamma
;
; ADDED WITH VERSION 1.4:
; SolveDiff
; FresnelC
; FresnelS
; Clausen
; IncompleteGamma
; Variance
; StandardDeviation
; NormalDistributonPDF
; GeneticIteration
; GeneticCrossPairs
;
; ADDED WITH VERSION 1.5:
; Graph
; GraphAddPoint
; GraphAddLink
; GraphMarkPoint
; GraphGetMark
; GraphMarkAll
; GraphGetConnections
; GraphGetPathLength
; GraphFindPathDijkstra
;
; ADDED WITH VERSION 1.6:
; VectorDistance
; ATan2
; AlphaMaxBetaMin
; Triangle
; TriangleGetAngles
; LevenshteinDistance
;
; ADDED WITH VERSION 1.7:
; Mandelbrot
; WarpFactor
; LorenzFactor
; TimeDilation
; LengthContraction
; Mollify
; BellCurveMollifier
; LinearMollifier
; ConstantMollifier
; SharpMollifier
;
; ADDED WITH VERSION 1.8:
; Si
; Ci
; Shi
; Chi
; RandomMatrix
; Covariance
; CentralMoment
; Kurtosis
; Skewness
; CorrelationPCC
; MatrixGetRow
; MatrixGetCol
; MatrixCellwisePower
; MatrixCellwiseMultiply
; DFT
; IDFT
; DFT2D
; IDFT2D
; DCT
; IDCT
; IntegralQuadpackQNG
; IntegralQuadpackQK
; IntegralQuadpackQK15
; IntegralQuadpackQK21
; RandomCreate
; RandomNextValue
; ===============================================================================================================================
