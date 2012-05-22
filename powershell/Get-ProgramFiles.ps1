function Get-ProgramFilesPath($childpath)
{
    $fullpath = join-path ${env:ProgramFiles} $childpath
    if (test-path $fullpath) {
        return $fullpath
    }
    
    $fullpath = $fullpath -replace "C:\\", "D:\"
    if (test-path $fullpath) {
        return $fullpath
    }
    return "" # path not found
}

function Get-ProgramFilesPathX86($childpath)
{
    $fullpath = join-path ${env:ProgramFiles(x86)} $childpath
    if (test-path $fullpath) {
        return $fullpath
    }
    
    $fullpath = $fullpath -replace "C:\\", "D:\"
    if (test-path $fullpath) {
        return $fullpath
    }
    return "" # path not found
}