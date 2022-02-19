@echo off

goto start

::-------------------------------------------------------------------------------
:DoWithData
::GetDataFromFile_Data存储文件内容

echo 文件内容为[%GetDataFromFile_Data%]
pause

exit

::-------------------------------------------------------------------------------




:start

:: (x.1)从文件获取数据
set GetDataFromFile_Callback=Continue1
goto GetDataFromFile
:Continue1
if  defined GetDataFromFile_Data (
	set GetAdmin_Callback=DoWhenMeetSituation
	goto GetAdmin 
) 



::从Input获取并存到文件然后重新开始	 
::echo 没有从文件获取到数据，尝试从input获取
set GetDataFromInput_Callback=Continue2
goto GetDataFromInput
:Continue2
::echo 从input获取到数据,保存到临时文件
echo %GetDataFromInput_Data%>"%~f0.tmp"
goto start



:DoWhenMeetSituation
::已经获取到权限且文件中存储了数据
::(x.x.1)获取文件内容并删除文件
set GetDataFromFile_Callback=DoWhenMeetSituation_OnGetData
goto GetDataFromFile

:DoWhenMeetSituation_OnGetData
del "%~f0.tmp"
goto DoWithData


::-------------------------------------------------------------------------------
:: GetDataFromInput(start)
:: [int] GetDataFromInput_Callback 执行后跳转到的位置
:: [out] GetDataFromInput_Data 获取到的数据
:GetDataFromInput

echo 1您可以拖动文件到本程序快捷方式上使用。
echo 2您也可以拖动文件到本窗口后按回车使用。
echo 3还可以在下方输入文件路径后按回车使用。

set GetDataFromInput_Data=%*%
if not defined  GetDataFromInput_Data (
	set /p "GetDataFromInput_Data=>："
)

goto %GetDataFromInput_Callback%
:: GetDataFromInput(end)



::-------------------------------------------------------------------------------
:: GetDataFromFile(start)
:: [int] GetDataFromFile_Callback 执行后跳转到的位置
:: [out] GetDataFromFile_Data 获取到的数据
:GetDataFromFile
set GetDataFromFile_Data=
 
if  exist "%~f0.tmp" (set /p GetDataFromFile_Data=<"%~f0.tmp")
goto %GetDataFromFile_Callback%  

:: GetDataFromFile(end)





::-------------------------------------------------------------------------------
:: GetAdmin(start)
:: 功能 获取管理员权限
:: [int] GetAdmin_Callback 执行后跳转到的位置

:GetAdmin

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" 
 
if '%errorlevel%' NEQ '0' (  
    goto GetAdmin_UACPrompt  
) else ( goto GetAdmin_gotAdmin )  
   
:GetAdmin_UACPrompt  
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs" 
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs" 
    "%temp%\getadmin.vbs" 
    exit /B  
   
:GetAdmin_gotAdmin  
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )  
    pushd "%CD%" 
    CD /D "%~dp0" 
 
goto %GetAdmin_Callback%

:: GetAdmin(end)





 