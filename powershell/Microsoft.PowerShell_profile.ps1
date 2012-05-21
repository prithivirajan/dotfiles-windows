# Profile setup for the console host shell
$dotfiles = resolve-path ~/dotfiles/
$scripts = join-path $dotfiles "powershell"

# Helper functions for user/computer session management
function invoke-userLogout { shutdown /l /t 0 }
function invoke-systemShutdown { shutdown /s /t 5 }
function invoke-systemReboot { shutdown /r /t 5 }
function invoke-systemSleep { RunDll32.exe PowrProf.dll,SetSuspendState }
function invoke-terminalLock { RunDll32.exe User32.dll,LockWorkStation }

# Aliases
set-alias logout invoke-userLogout
set-alias halt invoke-systemShutdown
set-alias restart invoke-systemReboot
if (test-path alias:\sleep) { remove-item alias:\sleep -force }
set-alias sleep invoke-systemSleep -force
set-alias lock invoke-terminalLock


# Utilities
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

# Find the ssh-agent.exe executable
# http://haacked.com/archive/2011/12/19/get-git-for-windows.aspx
$gitbin = Get-ProgramFilesPathX86 "\Git\bin"
$gitsshagent = join-path $gitbin "ssh-agent.exe"
if (test-path $gitsshagent)
{
    $env:path += ";" + $gitbin
}

# Load posh-git example profile
. $scripts\Modules\posh-git\profile.example.ps1

# Sets Visual Studio 2010 environment
function Set-VS2010()
{
	$vcvars = Get-ProgramFilesPathX86 "Microsoft Visual Studio 10.0\VC\vcvarsall.bat"
    if (Test-Path $vcvars)
    {
        Invoke-BatchFile $vcvars
    	[System.Console]::Title = "Visual Studio 2010 Windows PowerShell"
    }
}

# Load posh-git example profile
$poshgit = join-path $scripts "\modules\posh-git\profile.example.ps1"
. $poshgit
