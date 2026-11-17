$ErrorActionPreference = "Stop"

cd ../FFmpeg
# Env
$id = "FFmpeg.LGPL"
$license = "LGPL-3.0-or-later"
$folder = "ffmpeg-master-latest-win64-lgpl-shared"
$version = (Get-Date -Format "yyyyMMdd") + ".1.0"

$zipFile = "./" + $folder + ".zip"

# Download and expand FFmpeg
$url = "https://github.com/FFmpeg-Builds/FFmpeg-Builds/releases/download/latest/$folder.zip"
$maxAttempts = 5
for ($attempt = 1; $attempt -le $maxAttempts; $attempt++) {
    try {
        Invoke-WebRequest -Uri $url -OutFile $zipFile
        break
    }
    catch {
        if ($attempt -eq $maxAttempts) { throw }
        Write-Warning "Download failed (attempt $attempt/$maxAttempts): $($_.Exception.Message). Retrying in 30s..."
        Start-Sleep -Seconds 30
    }
}
Expand-Archive -Path $zipFile -DestinationPath ./ -Force
 
cd $folder

# Get all lib file name
$libraries = (Get-ChildItem -Path 'lib' -Filter *.lib | Select-Object -ExpandProperty Name) -join ';'
 
 New-Item -ItemType Directory -Path 'native' -Force
 New-Item -ItemType Directory -Path 'netstandard' -Force
# Copy file
$srcFile = "../native/FFmpeg.targets"
$dstFile = "native/$id.targets" 
(Get-Content $srcFile) -replace '\$libraries', $libraries | Set-Content $dstFile
 
$srcFile = "../netstandard/FFmpeg.targets"
$dstFile = "netstandard/$id.targets"
Copy-Item $srcFile -Destination $dstFile -Recurse -Force

$srcFile = "../favicon.png"
$dstFile = "favicon.png"
Copy-Item $srcFile -Destination $dstFile -Force

$srcFile = "../README.md"
$dstFile = "README.md"
Copy-Item $srcFile -Destination $dstFile -Force

$srcFile = "../FFmpeg.nuspec"
$dstFile = "$id.$version.nuspec" 
(Get-Content $srcFile) -replace '\$version', $version -replace '\$id', $id -replace '\$license', $license | Set-Content $dstFile
 
# nuget pack
nuget pack $dstFile
if ($LASTEXITCODE -ne 0) {
    throw "nuget pack failed with exit code $LASTEXITCODE"
}

