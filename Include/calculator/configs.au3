; configuration utils:
#include "grlobals.au3"
#include "language_manager.au3"
#include-once
func _config_start($sConfigPath)
if not FileExists($sConfigPath) Then return SetError (1, 0, "")

EndFunc