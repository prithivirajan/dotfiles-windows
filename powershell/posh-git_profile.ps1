Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Load posh-git module from current directory
Import-Module .\modules\posh-git

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-git


# Set up a simple prompt, adding the git prompt parts inside git repos
function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-Host($pwd) -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return "> "
}

Enable-GitColors

Pop-Location

# Find and launch pageant.exe, load secret key
# See: http://www.federicosilva.net/2012/03/how-to-remember-your-ssh-passphrase.html
$ppk = join-path ${env:UserProfile} ".ssh\mloskot@dog.putty.ppk"
if (test-path $ppk)
{
    $pageant = Get-ProgramFilesPathX86("PuTTY\pageant.exe")
    if (test-path $pageant)
    {
        Write-Verbose("Loading '$ppk' with '$pageant'")
        & $pageant $ppk
    }
}