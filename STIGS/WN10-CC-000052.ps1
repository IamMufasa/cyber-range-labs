<#
.SYNOPSIS
    Enforces STIG requirement WN10-CC-000052 by prioritizing ECC curves 
    with longer key lengths.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-09-03
    Last Modified   : 2025-09-03
    Version         : 1.0
    STIG-ID         : WN10-CC-000052

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-CC-000052.ps1
#>

# ------------------- PowerShell Script -------------------

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
$ValueName = "EccCurves"
$DesiredValue = "NistP384,NistP256"   # Longer ECC curves first (STIG-compliant)

Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type String
Write-Output "Policy updated: ECC curves prioritized (NistP384, NistP256) (STIG-compliant)."
