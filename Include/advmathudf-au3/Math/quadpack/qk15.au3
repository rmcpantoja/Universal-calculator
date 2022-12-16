#include-once

Global Const $__g_ADVMATHUDF_QK15_xgk[8] = [ _
  0.991455371120812639206854697526329, _
  0.949107912342758524526189684047851, _
  0.864864423359769072789712788640926, _
  0.741531185599394439863864773280788, _
  0.586087235467691130294144838258730, _
  0.405845151377397166906606412076961, _
  0.207784955007898467600689403773245, _
  0.000000000000000000000000000000000]

Global Const $__g_ADVMATHUDF_QK15_wg[4] = [ _
  0.129484966168869693270611432679082, _
  0.279705391489276667901467771423780, _
  0.381830050505118944950369775488975, _
  0.417959183673469387755102040816327]

Global Const $__g_ADVMATHUDF_QK15_wgk[8] = [ _
  0.022935322010529224963732008058970, _
  0.063092092629978553290700663189204, _
  0.104790010322250183839876322541518, _
  0.140653259715525918745189590510238, _
  0.169004726639267902826583426598550, _
  0.190350578064785409913256402421014, _
  0.204432940075298892414161999234649, _
  0.209482141084727828012999174891714]

Func IntegralQuadpackQK15($fnFunction, $vStart, $vEnd, $aAdditionalParams = 0)
	Local $fv1[8], $fv2[8]
	Return IntegralQuadpackQK(8, $__g_ADVMATHUDF_QK15_xgk, $__g_ADVMATHUDF_QK15_wg, $__g_ADVMATHUDF_QK15_wgk, $fv1, $fv2, $fnFunction, $vStart, $vEnd, $aAdditionalParams)
EndFunc