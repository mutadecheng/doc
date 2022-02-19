
cd /D %~dp0

nssm install mcc dotnet.exe
nssm set mcc AppParameters "App.MCC.Station.dll"
nssm set mcc AppDirectory "G:\Program Files\MCC_vr\MCC"
nssm set mcc AppStdout "G:\Program Files\MCC_vr\MCC\Logs\nssm.log"
nssm set mcc AppStderr "G:\Program Files\MCC_vr\MCC\Logs\nssm.log"
 
nssm start mcc

pause