#include <GUIConstantsEx.au3>
#include <Array.au3>

;~ ; Here is the array
;~ Global $aArray[5][2] = [["Andy", "Football"], ["Jon", "Swimming"], ["Jeremy", "Tennis"], ["Carol", "Basketball"], ["Vicky", "Hockey"]]

;~ ; And here we get the elements into a list
;~ $sList = ""
;~ For $i = 0 To UBound($aArray,1) -1
;~     $sList &= "|" & $aArray[$i][0]
;~ Next

;load file data
$aData = IniReadSection("Combo.ini","Data")
$aArray = $aData

; List element
$sList = ""

For $i = 1 To UBound($aArray,1) -1
    $sList &= "|" & $aArray[$i][0]
Next

; Create a GUI
#include <GUIConstantsEx.au3>

$hGUI = GUICreate("Test", 500, 500)

; Create the combo
$hCombo = GUICtrlCreateCombo("", 10, 10, 200, 20)
; And fill it
GUICtrlSetData($hCombo, $sList)

; Create label
$hLabel = GUICtrlCreateLabel("", 220, 15, 200, 20)

GUISetState()
While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $hCombo
            $sName = GUICtrlRead($hCombo)
            $iIndex = _ArraySearch($aArray, $sName)
            If Not @error Then
                GUICtrlSetData($hLabel, $aArray[$iIndex][1])
                ;save file ini
                $sFilePath = @ScriptDir & "\Combo.ini"
                IniWrite($sFilePath, "Func", "F1", $aArray[$iIndex][1])
            EndIf
    EndSwitch
WEnd