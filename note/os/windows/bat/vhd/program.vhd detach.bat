::��ǰ�������ļ���Ϊ  "vhd�ļ�����(����׺)" +" " +"attach|detach"

@echo off
set name=%~n0
set opt=%name:~-6%
set vhdPath=%~dp0%name:~0,-7%

echo ��ǰ�ļ���Ϊ��%name%
echo ������%opt%
echo vhd�ļ�����%vhdPath%
  

echo select vdisk file= "%vhdPath%" >vhdsel

echo %opt% vdisk>>vhdsel

echo list disk>>vhdsel

diskpart /s vhdsel

del /f /q vhdsel

����
 
::pause

exit