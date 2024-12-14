function patch {
    param(
        [string]$apkName,
        [string]$alias
    )
    $apkPath = "$apkName.apk"
    if (Test-Path $apkPath) {
        java -jar revanced-cli.jar patch -p patches.rvp --legacy-options=$alias -o "release\$apkName-$alias.apk" $apkPath
    } else {
        Write-Host "[-] Not found $apkName"
        exit 1
    }
}
if (-not (Test-Path "release")) {
    New-Item -Path "release" -ItemType Directory -Force | Out-Null
}

Invoke-WebRequest -Uri "https://cdn.azul.com/zulu/bin/zulu17.54.21-ca-jdk17.0.13-win_x64.msi" -OutFile "zulu.msi"
msiexec /i zulu.msi ADDLOCAL=FeatureJavaHome,FeatureEnvironment /qn

patch "youtube" "revanced-extended"