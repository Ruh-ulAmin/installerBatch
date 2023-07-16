@echo off
setlocal enabledelayedexpansion

set url=agracurry.com

rem Move logo.png to the Pictures folder
set pictures_folder="%USERPROFILE%\Pictures"
set logo_icon=!~dp0logo.png
echo Moving logo.png to the Pictures folder...
xcopy /y /i "!logo_icon!" %pictures_folder%

rem Create Chrome shortcut
set chrome_shortcut="%USERPROFILE%\Desktop\Chrome - Agra Curry.lnk"
echo Creating Chrome shortcut...
powershell.exe -c "$s = (New-Object -ComObject WScript.Shell).CreateShortcut(!chrome_shortcut!); $s.TargetPath = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Google Chrome.lnk'; $s.Arguments = ' !url!'; $s.Description = 'Agra Curry'; $s.IconLocation = %pictures_folder%\logo.png; $s.Save()"

rem Create Firefox shortcut
set firefox_shortcut="%USERPROFILE%\Desktop\Firefox - Agra Curry.lnk"
echo Creating Firefox shortcut...
powershell.exe -c "$s = (New-Object -ComObject WScript.Shell).CreateShortcut(!firefox_shortcut!); $s.TargetPath = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Mozilla Firefox.lnk'; $s.Arguments = ' !url!'; $s.Description = 'Agra Curry'; $s.IconLocation = %pictures_folder%\logo.png; $s.Save()"

echo Shortcuts created on the desktop.

endlocal
