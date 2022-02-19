@echo off

 
  set oriStr=2.1.1.356
set destStr=2.1.1.359
 

cd /d %~dp0
 
for /r %%i in (*.csproj) do (
:: echo [%%i]
call :replaceFileStr %oriStr% %destStr% "%%i"
) 

echo 文件替换完成
pause
exit


::--------------------------------------------------------
::-- Function 替换文件中的字符串
::-- demo call :replaceFileStr 2.1.1.356 2.1.1.357 "b\a 副本.txt" 
::-- start

:replaceFileStr

set oldStr=%1
set newStr=%2
set filePath=%3
echo 替换:[%oldStr%]-[%newStr%] [%filePath%]

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

:: 参考 https://zhidao.baidu.com/question/1708120484208936500.html   bat 替换txt文本
:: 参考 https://bbs.csdn.net/topics/260009981
:: 参考 https://blog.csdn.net/u012821093/article/details/53906619/   开启延迟变量
:: 参考 https://www.cnblogs.com/leonlipfsj/p/10164005.html  保留原始文件换行和空格
