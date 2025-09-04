<#
.SYNOPSIS
    Enforces STIG requirement WN10-CC-000205 by ensuring Windows telemetry 
    is not configured to "Full".

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-09-03
    Last Modified   : 2025-09-03
    Version         : 1.0
    STIG-ID         : WN10-CC-000205

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-CC-000205.ps1
#>

# ------------------- PowerShell Script -------------------

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
If (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }

$ValueName = "AllowTelemetry"
$DesiredValue = 1   # 0 = Security (Enterprise only), 1 = Basic (STIG-compliant)

Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
Write-Output "Policy updated: Telemetry set to Basic (not Full) (STIG-compliant)."
