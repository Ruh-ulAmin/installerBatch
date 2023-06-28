@echo off
setlocal

set /p "link=Enter the website or Google Drive link: "
set "logFile=%~dp0download_links.txt"

echo Searching for downloadable URLs...

echo %link% | findstr /C:"https://drive.google.com/file/" > nul
if not errorlevel 1 (
    echo Google Drive link detected.
    echo Obtaining direct download link...
    powershell -Command "$webContent = Invoke-WebRequest -Uri '%link%' -UseBasicParsing; $directLink = $webContent.ParsedHtml.getElementsByTagName('a') | Where-Object { $_.href -like 'https://drive.google.com/uc*' -and $_.innerHTML -ne $null }; if ($directLink) { $directLink.href }" > "%logFile%"

    set /p directLink=<"%logFile%"
    if not defined directLink (
        echo Failed to obtain the direct download link.
        echo Please make sure the Google Drive link is publicly accessible and try again.
        exit /b
    )

    echo Downloadable URL found:
    echo %directLink%

    echo File name: %logFile%
) else (
    echo General website link detected.
    powershell -Command "$webContent = Invoke-WebRequest -Uri '%link%' -UseBasicParsing; $matches = ([regex]::Matches($webContent.Content, '<a\s+(?:[^>]*?\s+)?href=([""'])(.*?)\1(?=\s|>)')); foreach ($match in $matches) { Write-Output $match.Groups[2].Value }" > "%logFile%"

    echo The download links have been saved to: %logFile%
)

echo.
echo Waiting for 5 seconds before exiting...
timeout /t 5 > nul
endlocal
