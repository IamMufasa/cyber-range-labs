<#
.SYNOPSIS
    Enforces STIG requirement WN10-CC-000170 by enabling the setting that 
    allows Microsoft accounts to be optional for modern style apps.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-08-23
    Last Modified   : 2025-08-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000170

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-CC-000170.ps1
#>

# ------------------- PowerShell Script -------------------

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
$ValueName = "MSAOptional"
$DesiredValue = 1  # 1 = Microsoft accounts optional (STIG-compliant)

# Ensure registry path exists
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Get current value
$CurrentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName
Write-Output "Current MSAOptional value: $CurrentValue"

# Apply fix if not compliant
If ($CurrentValue -ne $DesiredValue) {
    Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
    Write-Output "Policy updated: Microsoft accounts are now optional for modern style apps (STIG-compliant)."
}
else {
    Write-Output "Already compliant: Microsoft accounts are optional for modern style apps."
} 
