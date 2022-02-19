::当前批处理文件名为  "批量关闭进程" +" " +"待查找字符串"

@echo off&setlocal enabledelayedexpansion
title %~n0
set fileName=%~n0
set str=%fileName:~7%
echo 批量关闭进程[%str%]:

for /f "delims=" %%a in ('tasklist /v  /nh /fo csv') do (
     set "a=%%a"&set "flag="
     for %%a in (%str%) do if "!a:%%a=!" neq "!a!" set "flag=a"
     if defined flag ( 
        echo --------------------
        echo %%a
        for /f "tokens=2 delims=," %%a in ("!a!") do taskkill /f /pid %%~a
     )
)

pause