@echo off

goto start

::-------------------------------------------------------------------------------
:DoWithData
::GetDataFromFile_Data�洢�ļ�����

echo �ļ�����Ϊ[%GetDataFromFile_Data%]
pause

exit

::-------------------------------------------------------------------------------




:start

:: (x.1)���ļ���ȡ����
set GetDataFromFile_Callback=Continue1
goto GetDataFromFile
:Continue1
if  defined GetDataFromFile_Data (
	set GetAdmin_Callback=DoWhenMeetSituation
	goto GetAdmin 
) 



::��Input��ȡ���浽�ļ�Ȼ�����¿�ʼ	 
::echo û�д��ļ���ȡ�����ݣ����Դ�input��ȡ
set GetDataFromInput_Callback=Continue2
goto GetDataFromInput
:Continue2
::echo ��input��ȡ������,���浽��ʱ�ļ�
echo %GetDataFromInput_Data%>"%~f0.tmp"
goto start



:DoWhenMeetSituation
::�Ѿ���ȡ��Ȩ�����ļ��д洢������
::(x.x.1)��ȡ�ļ����ݲ�ɾ���ļ�
set GetDataFromFile_Callback=DoWhenMeetSituation_OnGetData
goto GetDataFromFile

:DoWhenMeetSituation_OnGetData
del "%~f0.tmp"
goto DoWithData


::-------------------------------------------------------------------------------
:: GetDataFromInput(start)
:: [int] GetDataFromInput_Callback ִ�к���ת����λ��
:: [out] GetDataFromInput_Data ��ȡ��������
:GetDataFromInput

echo 1�������϶��ļ����������ݷ�ʽ��ʹ�á�
echo 2��Ҳ�����϶��ļ��������ں󰴻س�ʹ�á�
echo 3���������·������ļ�·���󰴻س�ʹ�á�

set GetDataFromInput_Data=%*%
if not defined  GetDataFromInput_Data (
	set /p "GetDataFromInput_Data=>��"
)

goto %GetDataFromInput_Callback%
:: GetDataFromInput(end)



::-------------------------------------------------------------------------------
:: GetDataFromFile(start)
:: [int] GetDataFromFile_Callback ִ�к���ת����λ��
:: [out] GetDataFromFile_Data ��ȡ��������
:GetDataFromFile
set GetDataFromFile_Data=
 
if  exist "%~f0.tmp" (set /p GetDataFromFile_Data=<"%~f0.tmp")
goto %GetDataFromFile_Callback%  

:: GetDataFromFile(end)





::-------------------------------------------------------------------------------
:: GetAdmin(start)
:: ���� ��ȡ����ԱȨ��
:: [int] GetAdmin_Callback ִ�к���ת����λ��

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





 