cd ../FFmpeg
# Env
$id = "FFmpeg.LGPL"
$license = "LGPL-3.0-or-later"
$folder = "ffmpeg-master-latest-win64-lgpl-shared"
$version = (Get-Date -Format "yyyyMMdd") + ".1.0"

$zipFile = "./" + $folder + ".zip"

# Download and expand FFmpeg
Invoke-WebRequest -Uri "https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-lgpl-shared.zip" -OutFile $zipFile
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
