<#
.SYNOPSIS
    Enforces STIG requirement WN10-CC-000050 by configuring Hardened UNC paths 
    for SYSVOL and NETLOGON shares with mutual authentication and integrity.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-09-03
    Last Modified   : 2025-09-03
    Version         : 1.0
    STIG-ID         : WN10-CC-000050

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-CC-000050.ps1
#>

# ------------------- PowerShell Script -------------------

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths"
If (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }

New-ItemProperty -Path $RegPath -Name "\\*\SYSVOL"   -Value "RequireMutualAuthentication=1, RequireIntegrity=1" -PropertyType String -Force
New-ItemProperty -Path $RegPath -Name "\\*\NETLOGON" -Value "RequireMutualAuthentication=1, RequireIntegrity=1" -PropertyType String -Force

Write-Output "Policy updated: Hardened UNC paths for SYSVOL and NETLOGON defined (STIG-compliant)."
