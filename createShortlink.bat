@echo off
setlocal enabledelayedexpansion

set /p browser=Select a browser (1 for Chrome, 2 for Firefox): 

if "%browser%"=="1" (
    set browser_name=Chrome
    set browser_exe="C:\Program Files\Google\Chrome\Application\chrome.exe"
) else if "%browser%"=="2" (
    set browser_name=Firefox
    set browser_exe="C:\Program Files\Mozilla Firefox\firefox.exe"
) else (
    echo Invalid browser selection.
    exit /b
)

set /p shortcut_name=Enter a name for the shortcut: 
set /p url=Enter the URL: 

set /p icon_path=Enter the path to the icon file: 

set shortcut_path="%USERPROFILE%\Desktop\%shortcut_name%.lnk"

echo Creating %browser_name% shortcut...
powershell.exe -c "$s = (New-Object -ComObject WScript.Shell).CreateShortcut(!shortcut_path!); $s.TargetPath = %browser_exe%; $s.Arguments = '!url!'; $s.Description = '%shortcut_name%'; $s.IconLocation = !icon_path!; $s.Save()"

echo %browser_name% shortcut created on the desktop.

endlocal
