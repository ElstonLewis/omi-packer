del "C:\Windows\Outscale\logs\*"
CMD /c copy C:\Windows\Outscale\scripts\SetupComplete.cmd "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
CMD /c REG.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 1 /f
CMD /c C:\Windows\System32\sysprep\sysprep.exe /generalize /oobe /shutdown /unattend:C:\Windows\Outscale\sysprep\sysprep.xml