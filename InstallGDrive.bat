@echo off
echo Installing software...

set /p link=Enter the publicly shared link to the software:

echo Obtaining direct download link...
powershell -Command "$response = Invoke-WebRequest -Uri '%link%'; $directLink = $response.links.href | Where-Object { $_ -like '*uc?id=*' } | ForEach-Object { $_ -replace '/view', '' }; Write-Output $directLink" > temp.txt

set /p directLink=<temp.txt
del temp.txt

echo Downloading software...
powershell -command "(New-Object Net.WebClient).DownloadFile('%directLink%', 'software.exe')"

echo Installing software...
start /wait "" "software.exe"

echo Cleaning up...
del "software.exe"

echo Installation completed.
pause
