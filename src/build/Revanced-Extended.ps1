Set-ExecutionPolicy RemoteSigned

function patch {
    param(
        [string]$apkName,
        [string]$alias
    )
    $apkPath = "$apkName.apk"
    if (Test-Path $apkPath) {
        java -jar revanced-cli.jar patch -p patches.rvp --legacy-options=$alias -o "release\$apkName-$alias.apk" --purge $apkPath
    } else {
        Write-Host "[-] Not found $apkName"
        exit 1
    }
}
if (-not (Test-Path "release")) {
    New-Item -Path "release" -ItemType Directory -Force | Out-Null
}
patch "youtube" "revanced-extended"