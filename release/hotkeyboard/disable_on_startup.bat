@echo off

set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set filesys = CreateObject("Scripting.FileSystemObject") >> %SCRIPT%
echo filesys.DeleteFile "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\hotkeyboard.lnk" >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%

echo.
echo Success, HotKeyboard won't run on startup!
echo.
pause