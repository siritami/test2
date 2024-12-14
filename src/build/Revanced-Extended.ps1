function patch {
    param(
        [string]$apkName,
        [string]$patchOption
    )
    
    $apkPath = "$apkName.apk"
    if (Test-Path $apkPath) {
        java -jar revanced-cli.jar -p patches.rvp --legacy-options=$patchOption --keystore=src/_ks.keystore -o "release\$apkName-$patchOption.apk" --purge $apkPath
    } else {
        Write-Host "[-] Not found $apkPath"
        exit 1
    }
}

patch "youtube" "revanced-extended"
