::��ǰ�������ļ���Ϊ  "���ҽ���" +" " +"�������ַ���"

@echo off&setlocal enabledelayedexpansion
title %~n0
set fileName=%~n0
set str=%fileName:~5%
echo ���ҽ���[%str%]:

for /f "delims=" %%a in ('tasklist /v  /nh /fo csv') do (
     set "a=%%a"&set "flag="
     for %%a in (%str%) do if "!a:%%a=!" neq "!a!" set "flag=a"
     if defined flag ( 
        echo --------------------
        echo %%a
     )
)

pause