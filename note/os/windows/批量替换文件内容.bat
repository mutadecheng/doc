@echo off

 
  set oriStr=2.1.1.356
set destStr=2.1.1.359
 

cd /d %~dp0
 
for /r %%i in (*.csproj) do (
:: echo [%%i]
call :replaceFileStr %oriStr% %destStr% "%%i"
) 

echo �ļ��滻���
pause
exit


::--------------------------------------------------------
::-- Function �滻�ļ��е��ַ���
::-- demo call :replaceFileStr 2.1.1.356 2.1.1.357 "b\a ����.txt" 
::-- start

:replaceFileStr

set oldStr=%1
set newStr=%2
set filePath=%3
echo �滻:[%oldStr%]-[%newStr%] [%filePath%]

setlocal enabledelayedexpansion

(for /f "tokens=1* delims=:" %%i in ('findstr /n  .* %filePath%') do (
  set lineContent=%%j
  set "line=!lineContent: =!"
  if "!lineContent!"=="" (echo.) else  ( if "!line!"=="" (echo.)  else (
    set "lineContent=!lineContent:%oldStr%=%newStr%!"
    echo !lineContent!
  ))
 
))>file$.tmp
move file$.tmp %filePath% >nul

setlocal disabledelayedexpansion

goto:eof
::-- end
::--------------------------------------------------------


:: version 8

:: �ο� https://zhidao.baidu.com/question/1708120484208936500.html   bat �滻txt�ı�
:: �ο� https://bbs.csdn.net/topics/260009981
:: �ο� https://blog.csdn.net/u012821093/article/details/53906619/   �����ӳٱ���
:: �ο� https://www.cnblogs.com/leonlipfsj/p/10164005.html  ����ԭʼ�ļ����кͿո�
