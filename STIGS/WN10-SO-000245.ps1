<#
.SYNOPSIS
    Enforces STIG requirement WN10-SO-000245 by enabling User Account Control (UAC) 
    approval mode for the built-in Administrator account.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-09-03
    Last Modified   : 2025-09-03
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000245

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-SO-000245.ps1
#>

# ------------------- PowerShell Script -------------------

$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$ValueName = "FilterAdministratorToken"
$DesiredValue = 1   # 1 = Enabled (STIG-compliant)

If (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }

Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
Write-Output "Policy updated: Built-in Administrator now runs in UAC approval mode (STIG-compliant)."
