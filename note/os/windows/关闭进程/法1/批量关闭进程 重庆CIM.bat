::��ǰ�������ļ���Ϊ  "�����رս���" +" " +"�������ַ���"

@echo off&setlocal enabledelayedexpansion
title %~n0
set fileName=%~n0
set str=%fileName:~7%
echo �����رս���[%str%]:

for /f "delims=" %%a in ('tasklist /v') do (
     set "a=%%a"&set "flag="
     for %%a in (%str%) do if "!a:%%a=!" neq "!a!" set "flag=a"
     if defined flag ( 
        echo --------------------
        echo �رս���:
        for /f "tokens=10" %%a in ("!a!") do   echo %%a      
        for /f "tokens=2" %%a in ("!a!") do taskkill /f /pid %%a>nul 2>nul
     )
)

pause