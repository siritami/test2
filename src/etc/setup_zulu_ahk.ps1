function Update-EnvironmentVariables {
    # Clear existing session environment variables
    $envVariables = [System.Environment]::GetEnvironmentVariables("User")
    foreach ($key in $envVariables.Keys) {
        Remove-Item -Path Env:\${key} -ErrorAction SilentlyContinue
    }

    # Reload user environment variables
    foreach ($key in $envVariables.Keys) {
        $value = $envVariables[$key]
        if ($null -ne $value) {
            [Environment]::SetEnvironmentVariable($key, $value, "Process")
            ${env:$key} = $value
        }
    }

    # Reload system environment variables
    $sysEnvVariables = [System.Environment]::GetEnvironmentVariables("Machine")
    foreach ($key in $sysEnvVariables.Keys) {
        if (-not ${env:$key}) { # Avoid overwriting user-level variables
            $value = $sysEnvVariables[$key]
            if ($null -ne $value) {
                [Environment]::SetEnvironmentVariable($key, $value, "Process")
                ${env:$key} = $value
            }
        }
    }

    Write-Output "Environment variables have been updated in the current session."
}

New-Item -Path "release" -ItemType Directory -Force | Out-Null

Invoke-WebRequest -Uri "https://cdn.azul.com/zulu/bin/zulu17.54.21-ca-jdk17.0.13-win_x64.msi" -OutFile "zulu.msi"
Invoke-WebRequest -Uri "https://github.com/AutoHotkey/AutoHotkey/releases/download/v2.0.18/AutoHotkey_2.0.18.zip" -OutFile "D:\a\test2\test2\AutoHotkey.zip"

msiexec /i zulu.msi ADDLOCAL=FeatureJavaHome,FeatureEnvironment /qn
Expand-Archive -Path "D:\a\test2\test2\AutoHotkey.zip" -DestinationPath "." -Force
Start-Process "D:\a\test2\test2\AutoHotkey64.exe" -ArgumentList "D:\a\test2\test2\src\build\Revanced-Extended.ahk"
Update-EnvironmentVariables