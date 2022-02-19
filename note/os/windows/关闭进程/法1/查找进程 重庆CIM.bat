::当前批处理文件名为  "查找进程" +" " +"待查找字符串"

@echo off&setlocal enabledelayedexpansion
 
title %~n0
set fileName=%~n0
set str=%fileName:~5%
echo 查找进程[%str%]:

for /f "delims=" %%a in ('tasklist /v') do (
     set "a=%%a"&set "flag="
     for %%a in (%str%) do if "!a:%%a=!" neq "!a!" set "flag=a"
     if defined flag ( 
        for /f "tokens=10" %%a in ("!a!") do echo %%a
     )
)

pause