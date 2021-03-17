#include-once
#include <MsgBoxConstants.au3>
#include <IE.au3>
#include <INet.au3>
#include <WinAPIFiles.au3>


Global $serverVersionFile 
Global $UpdatePathIs
Global $serverUpdateExe 
Global $ToBeReplacedPathIs
Global $doDownload
Global $updateFailed
Global $retryornot


Func SetValuesUpdate($pServerVersionFile , $pUpdatePathIs, $pServerUpdateExe, $pToBeReplacedPathIs)
    $serverVersionFile = $pServerVersionFile
    $UpdatePathIs = $pUpdatePathIs
    $serverUpdateExe = $pServerUpdateExe
    $ToBeReplacedPathIs = $pToBeReplacedPathIs
EndFunc   ;==>GetCurrentSoftwareVersion

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

    If $localEXEversion = $remoteEXEversion Then        
        Global $updateFailed = false
    Else
        $retryornot = MsgBox(16 + 5,"Update error detected","Likely cause: Firewall/Antivirus prevented the download. ")
        Global $updateFailed = true
    EndIf
        If $retryornot = 4 Then
            GetCurrentSoftwareVersion()
            doVersionCheck()
        Else
    EndIf

EndFunc;DownloadDeleteRename