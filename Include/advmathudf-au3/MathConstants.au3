#include-once

; For checking whether we're using Advanced Math UDF or standard Math UDF
Global Const $USE_ADVMATHUDF = 1

; Integral()
Global Enum $M_INTEGRATE_TRAPEZOID = 0, _
			$M_INTEGRATE_SIMPSON

; Primality tests
Global Enum $M_PRIME_NAIVE1 = 0, _
			$M_PRIME_NAIVE2, _
			$M_PRIME_NAIVE3, _
			$M_PRIME_AKS, _
			$M_PRIME_LUCAS, _
			$M_PRIME_LUCASLEHMER

; Limit constants
Global Enum $M_LIMIT_PLUSINFINITY = 0, _
			$M_LIMIT_MINUSINFINITY

; GraphFindPathDijkstra()
Global Enum $M_GFP_LESS = 0, _
			$M_GFP_LESSOREQUAL

; AlphaMaxBetaMin()
Global Const $M_ALPHA_DEFAULT = (2 * Cos($Pi/8))/(1 + Cos($Pi/8))
Global Const $M_BETA_DEFAULT = (2 * Sin($Pi/8))/(1 + Cos($Pi/8))

; WarpFactor()
Global Enum $M_WARP_ORIGINALSERIES = 0, _
			$M_WARP_REFINED