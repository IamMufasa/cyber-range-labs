<#
.SYNOPSIS
    Enforces STIG requirement WN10-SO-000255 by configuring User Account Control (UAC) 
    to automatically deny elevation requests for standard users.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-09-03
    Last Modified   : 2025-09-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000255

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-SO-000255.ps1
#>

# ------------------- PowerShell Script -------------------

$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$ValueName = "ConsentPromptBehaviorUser"
$DesiredValue = 0   # 0 = Automatically deny elevation requests (STIG-compliant)

If (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }

Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
Write-Output "Policy updated: Standard user elevation requests automatically denied (STIG-compliant)."
