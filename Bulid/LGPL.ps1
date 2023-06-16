﻿cd ../FFmpeg
$folder = "ffmpeg-master-latest-win64-lgpl-shared"
$zipFile = "./" + $folder + ".zip"
Invoke-WebRequest -Uri "https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-lgpl-shared.zip" -OutFile $zipFile
Expand-Archive -Path $zipFile -DestinationPath ./ -Force
Remove-Item $zipFile -Force

$id = "FFmpeg.LGPL"
$version = (Get-Date -Format "yyyyMMdd") + ".1.0"
$srcfile = "FFmpeg.targets"
$dstfile = $id + ".targets"
Copy-Item $srcfile -Destination ($folder + "/" + $dstfile) -Force
$srcfile = "FFmpeg.nuspec"
$dstfile = $id + "." + $version  + ".nuspec"
$content = get-content $srcfile
foreach($line in $content) {
  $dstline = $line.Replace('$version', $version).Replace('$id', $id)
  Add-content ($folder + "/" + $dstfile) -Value $dstline
}
Get-ChildItem ./ -File | Copy-Item -Destination $folder -Force
cd $folder
nuget pack $dstfile
