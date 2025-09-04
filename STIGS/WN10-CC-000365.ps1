<#
.SYNOPSIS
    Enforces STIG requirement WN10-CC-000365 by preventing Windows apps 
    from being activated by voice while the system is locked.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-09-03
    Last Modified   : 2025-09-03
    Version         : 1.0
    STIG-ID         : WN10-CC-000365

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-CC-000365.ps1
#>

# ------------------- PowerShell Script -------------------

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"
If (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }

$ValueName = "LetAppsActivateWithVoiceWhileLocked"
$DesiredValue = 2   # 2 = Blocked (STIG-compliant)

Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
Write-Output "Policy updated: Voice activation disabled on lock screen (STIG-compliant)."
