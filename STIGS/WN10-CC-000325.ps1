 <#
.SYNOPSIS
    Enforces STIG requirement WN10-CC-000325 by disabling the automatic sign-in 
    of the last interactive user after a system-initiated restart.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-08-23
    Last Modified   : 2025-08-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000325

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-CC-000325.ps1
#>

# ------------------- PowerShell Script -------------------

$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$ValueName = "DisableAutomaticRestartSignOn"
$DesiredValue = 1  # 1 = Disabled (STIG-compliant), 0 = Enabled (non-compliant)

# Ensure the registry path exists
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Get current value
$CurrentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName
Write-Output "Current DisableAutomaticRestartSignOn value: $CurrentValue"

# Apply fix if not compliant
If ($CurrentValue -ne $DesiredValue) {
    Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
    Write-Output "Policy updated: Automatic sign-in after restart is now DISABLED (STIG-compliant)."
}
else {
    Write-Output "Already compliant: Automatic sign-in after restart is disabled."
}
 
