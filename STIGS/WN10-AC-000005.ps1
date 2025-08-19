 <#
.SYNOPSIS
    Enforces STIG requirement WN10-AC-000005 by configuring the Windows 10 Account Lockout Duration to at least 15 minutes (or 0 for manual unlock).

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-08-19
    Last Modified   : 2025-08-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AC-000005).ps1 
#>





# PowerShell Script to enforce STIG WN10-AC-000005
# Account lockout duration must be >= 15 minutes (or 0 for manual unlock)

# Desired lockout duration (set to 15 minutes)
$DesiredDuration = 15  

# Export current security policy
$TempFile = "$env:TEMP\secpol.cfg"
secedit /export /cfg $TempFile /quiet

# Read current value
$CurrentValue = (Get-Content $TempFile | Select-String "LockoutDuration").ToString().Split("=")[1].Trim()

Write-Output "Current Account Lockout Duration: $CurrentValue minutes"

# Apply fix if value is less than 15 and not 0
if (($CurrentValue -lt $DesiredDuration) -and ($CurrentValue -ne 0)) {
    (Get-Content $TempFile) -replace "LockoutDuration = \d+", "LockoutDuration = $DesiredDuration" | Set-Content $TempFile
    secedit /configure /db secedit.sdb /cfg $TempFile /areas SECURITYPOLICY /quiet
    gpupdate /force | Out-Null
    Write-Output "Policy updated: Account Lockout Duration set to $DesiredDuration minutes."
}
else {
    Write-Output "Policy already compliant (Duration = $CurrentValue). No change required."
}

# Cleanup
Remove-Item $TempFile -Force
 
