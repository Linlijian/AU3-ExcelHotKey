#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon\logo_dSi_8.ico
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=Auto updater to new version
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_CompanyName=Linlijian
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include-once
#include <MsgBoxConstants.au3>
#include <IE.au3>
#include <INet.au3>
#include <WinAPIFiles.au3>


Local $serverVersionFile = "https://raw.githubusercontent.com/Linlijian/AU3-ExcelHotKey/main/version.txt"
Local $UpdatePathIs = @ScriptDir & "\ExcelHotKey.exe"
Local $serverUpdateExe = "https://raw.githubusercontent.com/Linlijian/AU3-ExcelHotKey/main/ExcelHotKey.exe"
Local $ToBeReplacedPathIs= @ScriptDir & "\ExcelHotKey.exe"
Global $doDownload

;main
GetCurrentSoftwareVersion()
doVersionCheck()

Func GetCurrentSoftwareVersion()
    Global $localEXEversion = FileGetVersion($ToBeReplacedPathIs)
    Global $remoteEXEversion = _INetGetSource($serverVersionFile)
EndFunc   ;==>GetCurrentSoftwareVersion

Func doVersionCheck()
    If $localEXEversion < $remoteEXEversion Then
        Global $doDownload = InetGet($serverUpdateExe, $UpdatePathIs, $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND);
        Do
            Sleep(250)
        Until InetGetInfo($doDownload, $INET_DOWNLOADCOMPLETE)

        DownloadDeleteRename()
    EndIf
EndFunc;doVersionCheck

Func DownloadDeleteRename()

    FileDelete($ToBeReplacedPathIs)
    FileMove($UpdatePathIs,$ToBeReplacedPathIs,1)

    GetCurrentSoftwareVersion()

EndFunc;DownloadDeleteRename