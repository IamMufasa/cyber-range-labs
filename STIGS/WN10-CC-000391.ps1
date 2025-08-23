<#
.SYNOPSIS
    Enforces STIG requirement WN10-CC-000391 by disabling Internet Explorer on Windows 10.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-08-23
    Last Modified   : 2025-08-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000391

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-CC-000391.ps1
#>

# ------------------- PowerShell Script -------------------

# Registry path for disabling Internet Explorer
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$ValueName = "NoInternetExplorer"
$DesiredValue = 1  # 1 = Disable IE

# Ensure registry path exists
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Get current value
$CurrentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName
Write-Output "Current NoInternetExplorer value: $CurrentValue"

# Apply fix if not compliant
If ($CurrentValue -ne $DesiredValue) {
    Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
    Write-Output "Policy updated: Internet Explorer has been disabled (STIG-compliant)."
}
else {
    Write-Output "Already compliant: Internet Explorer is disabled."
}
