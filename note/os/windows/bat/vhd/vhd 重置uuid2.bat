@echo off


set /p vhd=请输入文件路径或拖动文件到本窗口并按回车：

 
 "C:\Program Files\Oracle\VirtualBox\VBoxManage" internalcommands sethduuid "%vhd%"
echo 重置成功
 
 
pause
exit

 