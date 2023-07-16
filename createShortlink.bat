@echo off
setlocal enabledelayedexpansion

set url=agracurry.com

rem Find Chrome installation path
set chrome_path=
for /f "usebackq tokens=2,*" %%A in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" /ve`) do (
    set chrome_path=%%B
)
if not defined chrome_path (
    echo Chrome is not installed.
) else (
    echo Chrome path: !chrome_path!
    set chrome_icon=!~dp0logo.png
    echo Moving logo.png to the Pictures folder...
    xcopy /y /i "!chrome_icon!" "%USERPROFILE%\Pictures"
    set shortcut_path="%USERPROFILE%\Desktop\AgraCurry.lnk"
    echo Creating Chrome shortcut...
    powershell.exe -c "$s=(New-Object -COM WScript.Shell).CreateShortcut(!shortcut_path!); $s.TargetPath=!chrome_path!; $s.Arguments=!url!; $s.IconLocation=!chrome_icon!; $s.Save()"

    echo Chrome shortcut created on the desktop.
)

rem Find Firefox installation path
set firefox_path=
for /f "usebackq tokens=2,*" %%A in (`reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe" /ve`) do (
    set firefox_path=%%B
)
if not defined firefox_path (
    echo Firefox is not installed.
) else (
    echo Firefox path: !firefox_path!
    set firefox_icon=!~dp0logo.png
    echo Moving logo.png to the Pictures folder...
    xcopy /y /i "!firefox_icon!" "%USERPROFILE%\Pictures"
    set shortcut_path="%USERPROFILE%\Desktop\AgraCurry.lnk"
    echo Creating Firefox shortcut...
    powershell.exe -c "$s=(New-Object -COM WScript.Shell).CreateShortcut(!shortcut_path!); $s.TargetPath=!firefox_path!; $s.Arguments=!url!; $s.IconLocation=!firefox_icon!; $s.Save()"

    echo Firefox shortcut created on the desktop.
)

endlocal
