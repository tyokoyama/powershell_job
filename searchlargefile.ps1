# 一定以上のサイズのファイルを抽出するスクリプト

param($targetPath)

$limitSize = 100000
$targetFileList = New-Object System.Collections.ArrayList

function searchDirectory($path) {
    $fileList = Get-ChildItem $path
    foreach($file in $fileList) {
        if($file.Attributes -eq "Directory") {
            searchDirectory($file.FullName)
        } else {
            if($file.Length -ge $limitSize) {
                $targetFileList.Add($file)
            }
        }
    }
}

searchDirectory($targetPath)

foreach($file in $targetFileList) {
    echo ([String]::Format("{0} : {1}", $file.FullName, $file.Length.ToString("#,0")))
}