<#
.SYNOPSIS
    Enforces STIG WN10-CC-000145 by requiring password on resume from sleep when on battery.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-08-19
    Last Modified   : 2025-08-19
    Version         : 1.0
    STIG-ID         : WN10-CC-000145

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-CC-000145.ps1
#>

# PowerShell Script
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"
$ValueName = "DCSettingIndex"
$DesiredValue = 1  # Enforce password prompt on battery resume

# Ensure registry path exists
If (!(Test-Path "$RegPath")) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Get current setting
$CurrentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName
Write-Output "Current setting for requiring password on wake (battery): $CurrentValue"

# Apply if not compliant
If ($CurrentValue -ne $DesiredValue) {
    Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
    Write-Output "Policy updated: Require password on resume (battery) is now enforced."
}
Else {
    Write-Output "Already compliant — no change needed."
}
