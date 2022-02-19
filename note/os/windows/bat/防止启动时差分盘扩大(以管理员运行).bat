 

reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FsDepends\Parameters  /v VirtualDiskExpandOnMount /t REG_DWORD /d 00000004 /f

pause