@echo off

::color 9F
::mode con cols=50 lines=15
::title VHD VHDX 加载工具

echo 您可以拖动VHD到本程序快捷方式上使用。
echo 您也可以拖动VHD到本窗口后按回车使用。
echo 还可以在下方输入VHD路径后按回车使用。
if "%*%" == "" goto 2
set vhd=%*%

:1

"C:\Program Files\Oracle\VirtualBox\VBoxManage" internalcommands sethduuid "%vhd%"
echo 重置成功
 
pause
exit

:2
set /p "vhd=>："
goto 1