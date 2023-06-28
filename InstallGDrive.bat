@echo off
echo Installing software...

set /p link=Enter the Google Drive link:

echo Downloading software...
powershell -command "(New-Object Net.WebClient).DownloadString('%link%') | Invoke-Expression"

echo Installation completed.
pause
