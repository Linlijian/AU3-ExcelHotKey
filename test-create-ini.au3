#include <GUIConstants.au3>

$MainGUI = GUICreate("INI Stuff", 202, 95, -1, -1)
$Input = GUICtrlCreateInput("", 8, 8, 185, 21)
$Clear = GUICtrlCreateButton ("Clear Input's Data", 8, 36, 185, 25)
$IniWrite = GUICtrlCreateButton("Ini Write", 8, 65, 57, 25, 0)
$IniRead = GUICtrlCreateButton("Ini Read", 72, 65, 57, 25, 0)
$IniDelete = GUICtrlCreateButton("Ini Delete", 136, 65, 57, 25, 0)
GUISetState(@SW_SHOW)

While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $IniWrite
            IniWrite ("Ini File.ini", "Input Section", "Input Info", GUICtrlRead($Input))
        Case $IniRead
            GUICtrlSetData ($Input, IniRead ("Ini File.ini", "Input Section", "Input Info", ""))
        Case $IniDelete
            IniDelete ("Ini File.ini", "Input Section", "Input Info")
        Case $Clear
            GUICtrlSetData ($Input, "")
    EndSwitch
WEnd