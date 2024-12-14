Set-ExecutionPolicy RemoteSigned

function patch {
    param(
        [string]$apkName,
        [string]$alias
    )
    
    # Define the path to the Java executable
    $javaPath = Get-ChildItem -Path "download\zulu-jdk-win_x64\Program Files\Zulu\zulu*\bin" -Filter "java.exe" -Recurse | Select-Object -First 1
    
    if ($javaPath) {
        $apkPath = "$apkName.apk"
        if (Test-Path $apkPath) {
            & "$javaPath" -jar revanced-cli.jar patch -p patches.rvp --legacy-options=$alias --keystore=src/_ks.keystore -o "release\$apkName-$alias.apk" --purge $apkPath
        } else {
            Write-Host "[-] Not found $apkName"
            exit 1
        }
    } else {
        Write-Host "[-] Java executable not found"
        exit 1
    }
}
$URL = (Invoke-RestMethod -Uri "https://api.azul.com/zulu/download/community/v1.0/bundles/latest/?jdk_version=21&bundle_type=jdk&javafx=false&ext=msi&os=windows&arch=x86&hw_bitness=64" -UseBasicParsing -Verbose).url
Invoke-RestMethod -Uri $URL -Outfile "download\zulu-jdk-win_x64.msi" -UseBasicParsing -Verbose
Start-Process "msiexec" -ArgumentList "/a `"download\zulu-jdk-win_x64.msi`"", "TARGETDIR=`"download\zulu-jdk-win_x64`"", "/qb" -Wait

patch "youtube" "revanced-extended"