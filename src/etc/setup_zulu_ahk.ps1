New-Item -Path "release" -ItemType Directory -Force | Out-Null

Invoke-WebRequest -Uri "https://cdn.azul.com/zulu/bin/zulu17.54.21-ca-jdk17.0.13-win_x64.msi" -OutFile "zulu.msi"
Invoke-WebRequest -Uri "https://github.com/AutoHotkey/AutoHotkey/releases/download/v2.0.18/AutoHotkey_2.0.18.zip" -OutFile "D:\a\test2\test2\AutoHotkey.zip"

msiexec /i zulu.msi ADDLOCAL=FeatureJavaHome,FeatureEnvironment /qn
Expand-Archive -Path "D:\a\test2\test2\AutoHotkey.zip" -DestinationPath "." -Force
Start-Process "D:\a\test2\test2\AutoHotkey64.exe" -ArgumentList "D:\a\test2\test2\src\build\Revanced-Extended.ahk"
$global:progressPreference = 'silentlyContinue'
Start-Sleep -s 400