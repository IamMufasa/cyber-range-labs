<#
.SYNOPSIS
    Enforces STIG requirement WN10-SO-000100 by configuring the SMB client 
    to always perform SMB packet signing.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-09-03
    Last Modified   : 2025-09-03
    Version         : 1.0
    STIG-ID         : WN10-SO-000100

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-SO-000100.ps1
#>

# ------------------- PowerShell Script -------------------

$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
$ValueName = "RequireSecuritySignature"
$DesiredValue = 1   # 1 = Required (STIG-compliant)

Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
Write-Output "Policy updated: SMB client now requires packet signing (STIG-compliant)."
