# Profile setup for the console host shell

$scripts = split-path $profile

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