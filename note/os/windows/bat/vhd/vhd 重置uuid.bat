@echo off

::color 9F
::mode con cols=50 lines=15
::title VHD VHDX ���ع���

echo �������϶�VHD���������ݷ�ʽ��ʹ�á�
echo ��Ҳ�����϶�VHD�������ں󰴻س�ʹ�á�
echo ���������·�����VHD·���󰴻س�ʹ�á�
if "%*%" == "" goto 2
set vhd=%*%

:1

"C:\Program Files\Oracle\VirtualBox\VBoxManage" internalcommands sethduuid "%vhd%"
echo ���óɹ�
 
pause
exit

:2
set /p "vhd=>��"
goto 1