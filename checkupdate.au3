#include <extprop.au3>
#include <array.au3>
$path = FileOpenDialog("Select a file to read attributes",@ScriptDir,"All (*.*)")
$prop = _GetExtProperty($path,-1)
_ArrayDisplay($prop,"Property Array")