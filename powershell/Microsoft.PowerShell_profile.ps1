# Profile setup for the console host shell

$scripts = split-path $profile

# Find the ssh-agent.exe executable
# http://haacked.com/archive/2011/12/19/get-git-for-windows.aspx
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"

# Load posh-git example profile
. $scripts\Modules\posh-git\profile.example.ps1

function Set-VS2010 {
    if (test-path ($scripts + "\vs2010.ps1")) {
        . $scripts\vs2010.ps1
    }
}