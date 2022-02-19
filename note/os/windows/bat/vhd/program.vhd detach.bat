::当前批处理文件名为  "vhd文件名称(含后缀)" +" " +"attach|detach"

@echo off
set name=%~n0
set opt=%name:~-6%
set vhdPath=%~dp0%name:~0,-7%

echo 当前文件名为：%name%
echo 操作：%opt%
echo vhd文件名：%vhdPath%
  

echo select vdisk file= "%vhdPath%" >vhdsel

echo %opt% vdisk>>vhdsel

echo list disk>>vhdsel

diskpart /s vhdsel

del /f /q vhdsel

　　
 
::pause

exit