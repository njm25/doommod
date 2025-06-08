@echo off
setlocal

:: Set output and temp file names
set OUTPUT=doommod.pk3
set TEMP_ZIP=doommod_temp.zip

:: Clean old files
if exist %OUTPUT% del %OUTPUT%
if exist %TEMP_ZIP% del %TEMP_ZIP%

:: Build the ZIP
echo Building %OUTPUT%...
powershell -NoProfile -Command ^
    "$ErrorActionPreference = 'Stop'; Compress-Archive -Force -Path 'zscript','sprites','sounds','SNDINFO','zscript.txt' -DestinationPath '%TEMP_ZIP%'"

:: Check for errors
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to build archive
    pause
    exit /b 1
)

:: Rename to .pk3
ren %TEMP_ZIP% %OUTPUT%

echo ✅ Build complete: %OUTPUT%

:: Launch GZDoom
echo Launching GZDoom...
start "" "C:\Users\Nico\Downloads\gzdoom-4-14-2-windows\gzdoom.exe" -iwad doom.wad -file "%OUTPUT%"

endlocal
