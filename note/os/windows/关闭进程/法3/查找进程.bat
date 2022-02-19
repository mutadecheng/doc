@echo off&setlocal enabledelayedexpansion

set str=赛扬产品
echo 查找进程[%str%]:

for /f "delims=" %%a in ('tasklist /v  /nh /fo csv') do (
     set "a=%%a"&set "flag="
     for %%a in (%str%) do if "!a:%%a=!" neq "!a!" set "flag=a"
     if defined flag ( 
        echo --------------------
        echo %%a
     )
)

pause