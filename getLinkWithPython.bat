@echo off
setlocal

set /p "link=Enter the website or Google Drive link: "
set "logFile=%~dp0download_links.txt"

echo Searching for downloadable URLs...

echo %link% | findstr /C:"https://drive.google.com/" > nul
if not errorlevel 1 (
    echo Google Drive link detected.
    echo Obtaining direct download link...
    python - <<EOF > "%logFile%"
import requests
from bs4 import BeautifulSoup

link = '%link%'
response = requests.get(link)
soup = BeautifulSoup(response.text, 'html.parser')
directLink = soup.find('a', href=lambda href: href and href.startswith('https://drive.google.com/uc'))
if directLink:
    print(directLink['href'])
else:
    print('')
EOF

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
    python - <<EOF > "%logFile%"
import requests
from bs4 import BeautifulSoup
import re

link = '%link%'
response = requests.get(link)
soup = BeautifulSoup(response.text, 'html.parser')
matches = soup.find_all('a', href=re.compile(r'https?://[^\s]+'))
download_links = [a['href'] for a in matches]
for link in download_links:
    print(link)
EOF

    echo The download links have been saved to: %logFile%
)

echo.
echo Waiting for 5 seconds before exiting...
timeout /t 5 > nul
endlocal
