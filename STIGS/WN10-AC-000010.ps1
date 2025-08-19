 <#
.SYNOPSIS
    Enforces STIG requirement WN10-AC-000010 by setting the Account Lockout Threshold 
    to 3 invalid logon attempts.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-08-19
    Last Modified   : 2025-08-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run this script with administrative privileges.
    Example:
        PS C:\> .\STIG-WN10-AC-000010.ps1
#>

# ------------------- PowerShell Script -------------------

$DesiredThreshold = 3
$TempFile = "$env:TEMP\secpol.cfg"

# Export current security policy
secedit /export /cfg $TempFile /quiet

# Force the LockoutBadCount setting to 3
(Get-Content $TempFile) -replace "LockoutBadCount = \d+", "LockoutBadCount = $DesiredThreshold" | Set-Content $TempFile

# Reapply updated security policy
secedit /configure /db secedit.sdb /cfg $TempFile /areas SECURITYPOLICY /quiet

# Refresh Group Policy
gpupdate /force | Out-Null

Write-Output "Policy updated: Account Lockout Threshold set to $DesiredThreshold invalid attempts."

# Cleanup
Remove-Item $TempFile -Force
 
