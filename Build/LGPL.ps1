cd ../FFmpeg
$id = "FFmpeg.LGPL"
$license = "LGPL-3.0-or-later"
$folder = "ffmpeg-master-latest-win64-lgpl-shared"
$zipFile = "./" + $folder + ".zip"
Invoke-WebRequest -Uri "https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-lgpl-shared.zip" -OutFile $zipFile
Expand-Archive -Path $zipFile -DestinationPath ./ -Force
Remove-Item $zipFile -Force

$version = (Get-Date -Format "yyyyMMdd") + ".1.0"
$srcfile = "FFmpeg.props"
$dstfile = $id + ".props"
Copy-Item $srcfile -Destination ($folder + "/" + $dstfile) -Force
$srcfile = "FFmpeg.targets"
$dstfile = $id + ".targets"
Copy-Item $srcfile -Destination ($folder + "/" + $dstfile) -Force
$srcfile = "FFmpeg.nuspec"
$dstfile = $id + "." + $version  + ".nuspec"
Clear-Content $dstfile
$content = get-content $srcfile
foreach($line in $content) {
  $dstline = $line.Replace('$version', $version).Replace('$id', $id).Replace('$license',$license)
  Add-content ($folder + "/" + $dstfile) -Value $dstline
}
Get-ChildItem ./ -File | Copy-Item -Destination $folder -Force
cd $folder
nuget pack $dstfile

