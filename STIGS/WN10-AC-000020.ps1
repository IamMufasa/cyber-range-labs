 <#
.SYNOPSIS
    Enforces STIG requirement WN10-AC-000020 by configuring Windows 10 to enforce password history,
    remembering the last 24 passwords to prevent reuse.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-08-19
    Last Modified   : 2025-08-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run this script with administrative privileges.
    Example:
        PS C:\> .\STIG-WN10-AC-000020.ps1
#>

# ------------------- PowerShell Script -------------------

$DesiredHistory = 24
$TempFile = "$env:TEMP\secpol.cfg"

# Export current security policy
secedit /export /cfg $TempFile /quiet

# Read current value
$CurrentValue = (Get-Content $TempFile | Select-String "PasswordHistorySize").ToString().Split("=")[1].Trim()

Write-Output "Current Enforce Password History: $CurrentValue"

# Apply fix if value is less than 24
if ($CurrentValue -lt $DesiredHistory) {
    (Get-Content $TempFile) -replace "PasswordHistorySize = \d+", "PasswordHistorySize = $DesiredHistory" | Set-Content $TempFile
    secedit /configure /db secedit.sdb /cfg $TempFile /areas SECURITYPOLICY /quiet
    gpupdate /force | Out-Null
    Write-Output "Policy updated: Enforce password history set to $DesiredHistory"
}
else {
    Write-Output "Policy already compliant (History = $CurrentValue). No change required."
}

# Cleanup
Remove-Item $TempFile -Force
 
