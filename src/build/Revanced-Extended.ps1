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

#Start-Process cmd -ArgumentList "/k java -jar D:\a\test2\test2\revanced-cli.jar patch -p D:\a\test2\test2\patches.rvp -o D:\a\test2\test2\release\youtube-revanced-extended.apk D:\a\test2\test2\youtube.apk"

Start-Process "D:\a\test2\test2\AutoHotkey64.exe" -ArgumentList "D:\a\test2\test2\src\build\Revanced-Extended.ahk"
$global:progressPreference = 'silentlyContinue'
Start-Sleep -s 180
#Start-Sleep -s 400
#patch "youtube" "revanced-extended"