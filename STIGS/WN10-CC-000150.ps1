 <#
.SYNOPSIS
    Enforces STIG requirement WN10-CC-000150 by ensuring the user is prompted 
    for a password on resume from sleep (plugged in).

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-08-19
    Last Modified   : 2025-08-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000150

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-CC-000150.ps1
#>

# ------------------- PowerShell Script -------------------

# Path to registry key that controls password prompt on wake when plugged in
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51"

# Ensure the registry path exists
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set AC setting (plugged in) to require password on resume (1 = enabled)
Set-ItemProperty -Path $RegPath -Name "ACSettingIndex" -Value 1 -Force

Write-Output "STIG WN10-CC-000150 enforced: Password prompt required on resume from sleep (plugged in)." 
