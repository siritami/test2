Set-ExecutionPolicy RemoteSigned

function patch {
    param(
        [string]$apkName,
        [string]$alias
    )
    
    $apkPath = "$apkName.apk"
	$javaPath = "download\zulu-jdk-win_x64\Program Files\Zulu\zulu*\bin\java.exe"
    if (Test-Path $apkPath) {
        $javaPath -jar revanced-cli.jar patch -p patches.rvp --legacy-options=$alias --keystore=src/_ks.keystore -o "release\$apkName-$alias.apk" --purge $apkPath
    } else {
        Write-Host "[-] Not found $apkName"
        exit 1
    }
}
function setup-zulu {
	$Url = "https://cdn.azul.com/zulu/bin/zulu17.54.21-ca-jdk17.0.13-win_x64.msi"
	$DownloadPath = "download\zulu-jdk-win_x64.msi"
	$ExtractPath = "download\zulu-jdk-win_x64"
	$Directory = [System.IO.Path]::GetDirectoryName($DownloadPath)
	if (-not (Test-Path -Path $Directory)) {
		New-Item -ItemType Directory -Path $Directory
	}

	$ExtractDirectory = [System.IO.Path]::GetDirectoryName($ExtractPath)
	if (-not (Test-Path -Path $ExtractDirectory)) {
		New-Item -ItemType Directory -Path $ExtractDirectory
	}

	Invoke-WebRequest -Uri $Url -OutFile $DownloadPath
	Write-Host "Download complete: $DownloadPath"

	Start-Process msiexec.exe -ArgumentList "/a `"$DownloadPath`" /qb TARGETDIR=`"$ExtractPath`"" -NoNewWindow -Wait
	Write-Host "Extraction complete: $ExtractPath"

}

if (-not (Test-Path "release")) {
    New-Item -Path "release" -ItemType Directory -Force | Out-Null
}
setup-zulu
patch "youtube" "revanced-extended"