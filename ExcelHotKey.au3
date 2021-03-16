#include <GUIConstantsEx.au3>
#include <Array.au3>

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=F:\Autoit\AU3-ExcelHotkey\icon\logo_dSi_6.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#Region ### START Global section ###
Global $Hotkey_config = "Hotkey.ini"
Global $sFilePath = @ScriptDir & '\' & $Hotkey_config
Global $aDataFunc
Global $aDataHotKey
Global $aDataConfig
#EndRegion ### END Global section ###

#Region ### START load ini ###
$aDataFunc = IniReadSection($Hotkey_config,"Func")
$aDataHotKey = IniReadSection($Hotkey_config,"HotKey")
$aDataConfig = IniReadSection($Hotkey_config,"Config")

$aData = IniReadSection($Hotkey_config,"Func")

If @error Or Not IsArray($aData) Then
    FWriteDefualt()
    $aDataFunc = IniReadSection($Hotkey_config,"Func")
    $aData = IniReadSection($Hotkey_config,"Func")
EndIf
If @error Or Not IsArray($aDataConfig) Then
    IniWrite($sFilePath, "Config", "Password", 'xxxx')
    IniWrite($sFilePath, "Config", "ColorHex", 'b0f303')
    IniWrite($sFilePath, "Config", "Time2Next", '60')
    $aDataConfig = IniReadSection($Hotkey_config,"Config")
EndIf

$aArray = $aData
$aDataFunc = $aData
$sList = ""

For $i = 1 To UBound($aArray,1) -1
    $sList &= "|" & $aArray[$i][0]
Next
#EndRegion ### END load ini ###

#Region ### START GUI ###
$hGUI = GUICreate("Config", 250, 300,-1,-1)

; Create the combo
$hLabelF1 = GUICtrlCreateLabel("F1", 10, 16, 100, 20)
$hLabelF2 = GUICtrlCreateLabel("F2", 10, 46, 100, 20)
$hLabelF3 = GUICtrlCreateLabel("F3", 10, 76, 100, 20)
$hLabelF4 = GUICtrlCreateLabel("F4", 10, 106, 100, 20)
$hLabelPassword = GUICtrlCreateLabel("Password Lock/Unlock", 10, 138, 120, 20)
$hLabelColorHex = GUICtrlCreateLabel("Color Hex", 10, 168, 120, 20)
$hLabelTime2Next = GUICtrlCreateLabel("Time to Next Lock/Unlock", 10, 198, 140, 20)

$hLabelFucn1 = GUICtrlCreateLabel("", 140, 16, 100, 20)
$hLabelFucn2 = GUICtrlCreateLabel("", 140, 46, 100, 20)
$hLabelFucn3 = GUICtrlCreateLabel("", 140, 76, 100, 20)
$hLabelFucn4 = GUICtrlCreateLabel("", 140, 106, 100, 20)

$hComboF1 = GUICtrlCreateCombo("", 30, 10, 100, 20)
$hComboF2 = GUICtrlCreateCombo("", 30, 40, 100, 20)
$hComboF3 = GUICtrlCreateCombo("", 30, 70, 100, 20)
$hComboF4 = GUICtrlCreateCombo("", 30, 100, 100, 20)

$hBtnStart = GUICtrlCreateButton("Start", 30, 240, 200, 40)

$hInputPassword = GUICtrlCreateInput('', 140, 136, 106, 22)
$hInputColorHex = GUICtrlCreateInput('', 140, 166, 106, 22)
$hInputTime2Next = GUICtrlCreateInput('', 140, 196, 106, 22)

; And fill it
GUICtrlSetData($hComboF1, $sList)
GUICtrlSetData($hComboF2, $sList)
GUICtrlSetData($hComboF3, $sList)
GUICtrlSetData($hComboF4, $sList)

If IsArray($aDataHotKey) Then
    $iF1 = _ArraySearch($aDataHotKey, 'F1')
    $dF1 = _ArraySearch($aDataFunc, $aDataHotKey[$iF1][1])
    GUICtrlSetData($hLabelFucn1, $aDataFunc[$dF1][0])
    $iF2 = _ArraySearch($aDataHotKey, 'F2')
    $dF2 = _ArraySearch($aDataFunc, $aDataHotKey[$iF2][1])
    GUICtrlSetData($hLabelFucn2, $aDataFunc[$dF2][0])
    $iF3 = _ArraySearch($aDataHotKey, 'F3')
    $dF3 = _ArraySearch($aDataFunc, $aDataHotKey[$iF3][1])
    GUICtrlSetData($hLabelFucn3, $aDataFunc[$dF3][0])
    $iF4 = _ArraySearch($aDataHotKey, 'F4')
    $dF4 = _ArraySearch($aDataFunc, $aDataHotKey[$iF4][1])
    GUICtrlSetData($hLabelFucn4, $aDataFunc[$dF4][0])
EndIf

GUICtrlSetData($hInputPassword, $aDataConfig[1][1])
GUICtrlSetData($hInputColorHex, $aDataConfig[2][1])
GUICtrlSetData($hInputTime2Next, $aDataConfig[3][1])

GUISetState()
While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $hBtnStart
            FStart()
        Case $hComboF1
            $sName = GUICtrlRead($hComboF1)
            $iIndex = _ArraySearch($aArray, $sName)
            If Not @error Then
                ;save file ini
                IniWrite($sFilePath, "HotKey", "F1", $aArray[$iIndex][1])
            EndIf
        Case $hComboF2
            $sName = GUICtrlRead($hComboF2)
            $iIndex = _ArraySearch($aArray, $sName)
            If Not @error Then
                ;save file ini
                IniWrite($sFilePath, "HotKey", "F2", $aArray[$iIndex][1])
            EndIf
        Case $hComboF3
            $sName = GUICtrlRead($hComboF3)
            $iIndex = _ArraySearch($aArray, $sName)
            If Not @error Then
                ;save file ini
                IniWrite($sFilePath, "HotKey", "F3", $aArray[$iIndex][1])
            EndIf
        Case $hComboF4
            $sName = GUICtrlRead($hComboF4)
            $iIndex = _ArraySearch($aArray, $sName)
            If Not @error Then
                ;save file ini
                IniWrite($sFilePath, "HotKey", "F4", $aArray[$iIndex][1])
            EndIf
    EndSwitch
WEnd
#EndRegion ### END GUI ###

#Region ### START Function ###
Func FStart()
    $hGUIStart = GUICreate("Runing", 214, 74)
    $hLabelStart = GUICtrlCreateLabel("Start. . .", 10, 10, 100, 20)

    GUISetState(@SW_HIDE, $hGUI)
    GUISetState(@SW_SHOW, $hGUIStart)

    IniWrite($sFilePath, "Config", "Password", GUICtrlRead($hInputPassword))
    IniWrite($sFilePath, "Config", "ColorHex", GUICtrlRead($hInputColorHex))
    IniWrite($sFilePath, "Config", "Time2Next", GUICtrlRead($hInputTime2Next))
    $aDataConfig = IniReadSection($Hotkey_config,"Config")
    
    While 1
		;event with form
        $nMsg = GUIGetMsg()
        
        $sList = FHotKeyLoad()

        HotKeySet('{'& $sList[1][0] &'}', $sList[1][1])
        HotKeySet('{'& $sList[2][0] &'}', $sList[2][1])
        HotKeySet('{'& $sList[3][0] &'}', $sList[3][1])
        HotKeySet('{'& $sList[4][0] &'}', $sList[4][1])

		Switch $nMsg
			Case $GUI_EVENT_CLOSE
				GUISetState(@SW_SHOW, $hGUI)	
				GUIDelete($hGUIStart)

                HotKeySet("{F1}")
                HotKeySet("{F2}")
                HotKeySet("{F3}")
                HotKeySet("{F4}")
				ExitLoop
		EndSwitch
	WEnd    
EndFunc
Func FWriteDefualt()
    IniWrite($sFilePath, "Func", "Copy", 'FCopy')
    IniWrite($sFilePath, "Func", "LookSheet", 'FLookSheet')
    IniWrite($sFilePath, "Func", "UnLookSheet", 'FUnLookSheet')
    IniWrite($sFilePath, "Func", "PrmatPainter", 'FFprmatPainter')
    IniWrite($sFilePath, "Func", "Hide", 'FHide')
    IniWrite($sFilePath, "Func", "UnHide", 'FUnHide')
    IniWrite($sFilePath, "Func", "TabColor", 'FTabColor')
    IniWrite($sFilePath, "Func", "NextSheetUnlock", 'FNextSheetUnlock')
    IniWrite($sFilePath, "Func", "NextSheetLock", 'FNextSheetLock')
    IniWrite($sFilePath, "Func", "ConditionRuld", 'FConditionRuld')
EndFunc
Func FHotKeyLoad()
    $aData = IniReadSection($Hotkey_config,"HotKey")
    If @error Or Not IsArray($aData) Then
        FWriteDefualt()
        $aData = IniReadSection($Hotkey_config,"HotKey")
    EndIf

    return $aData    
EndFunc 
Func FConditionRuld()
    Send('{Alt}')
	Send('{H}')
	Send('{L}')
	Send('{H}')
	Send('{G}')
	Send('0')
	Send('{ENTER}')
;~ <
	Send('{Alt}')
	Send('{H}')
	Send('{L}')
	Send('{H}')
	Send('{L}')
	Send('0')
	Send('{ENTER}')
EndFunc
Func FCopy()
    Send("{CTRLDOWN}c{CTRLUP}")
EndFunc
Func FLookSheet()
    Send("{ALT}")
    Send("Y")
    Send("1")
    Send("P")
    Send("S")
    Send(GUICtrlRead($hInputPassword))
    Send("{ENTER}")
    Send(GUICtrlRead($hInputPassword))
    Send("{ENTER}")
 EndFunc
 Func FUnLookSheet()
    Send("{ALT}")
    Send("Y")
    Send("1")
    Send("P")
    Send("S")
    Send(GUICtrlRead($hInputPassword))
    Send("{ENTER}")
 EndFunc
 Func FFprmatPainter()
    Send("{ALT}")
    Send("H")
    Send("F")
    Send("P")
 EndFunc
 Func FTabColor()
    Send("{ALT}")
    Send("Y")
    Send("1")
    Send("T")
    Send("M")
    Send("{RIGHT}")
    Send("{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}")
    Sleep(10)
    Send(GUICtrlRead($hInputColorHex))
    Send("{ENTER}")
 EndFunc
 Func FHide()
    Send("{ALT}")
    Send("Y")
    Send("1")
    Send("H")
 EndFunc
 Func FUnHide()
    Send("{ALT}")
    Send("Y")
    Send("1")
    Send("U")
 EndFunc
 Func test()
    Send("{CTRLDOWN}c{CTRLUP}")
 EndFunc
 Func FNextSheetUnlock()
    for $i = 1 to $aDataConfig[3][1]
        FUnLookSheet()
        Send("{CTRLDOWN}{PGDN}{CTRLUP}")
        Sleep(500)
    next
 EndFunc
 Func FNextSheetLock()
    for $i = 1 to $aDataConfig[3][1]
        FLookSheet()
        Send("{CTRLDOWN}{PGDN}{CTRLUP}")
        Sleep(500)
    next
 EndFunc
#EndRegion ### END Function ###