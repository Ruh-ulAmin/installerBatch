@echo off
echo Installing software...

set /p link=Enter the publicly shared link to the software:

echo Obtaining direct download link...
curl -s -L -c cookies.txt "%link%" > response.html
set "directLink="
for /F "tokens=2 delims=^<^>" %%G in (response.html) do (
    if "%%G" neq "" (
        set "directLink=%%G"
        goto :foundlink
    )
)
:foundlink
del response.html

echo Downloading software...
curl -L -b cookies.txt -o software.exe "%directLink%"

echo Installing software...
start /wait "" "software.exe"

echo Cleaning up...
del "software.exe"
del cookies.txt

echo Installation completed.
pause
