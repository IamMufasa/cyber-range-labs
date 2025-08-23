<#
.SYNOPSIS
    Enforces STIG requirement WN10-00-000090 by ensuring accounts are not configured 
    with the "Password never expires" option and forces a password change at next logon.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-08-23
    Last Modified   : 2025-08-23
    Version         : 1.2
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000090

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-00-000090.ps1
#>

# ------------------- PowerShell Script -------------------

# Get all local enabled users (excluding Administrator and Guest)
$Users = Get-LocalUser | Where-Object { $_.Enabled -and $_.Name -notin @("Administrator","Guest") }

foreach ($User in $Users) {
    try {
        # Ensure password expiration is enforced
        Set-LocalUser -Name $User.Name -PasswordNeverExpires $false
        
        # Force password change at next logon
        net user $($User.Name) /logonpasswordchg:yes | Out-Null

        Write-Output "Updated: $($User.Name) - Password expiration enforced and change required at next logon."
    }
    catch {
        Write-Output "Error updating ${User}: $($_)"
    }
}
