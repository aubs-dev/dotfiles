@echo off
tasklist /FI "IMAGENAME eq aseprite.exe" 2>NUL | find /I /N "aseprite.exe" >NUL
if "%ERRORLEVEL%"=="1" (
    start steam://rungameid/431730
)