 <#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-08-19
    Last Modified   : 2025-08-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000500).ps1 
#>



# PowerShell Script to fix Application Event Log MaxSize

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$ValueName = "MaxSize"
$DesiredValue = 32768  # Minimum required value in KB

# Ensure the registry path exists
If (!(Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Get current value (if it exists)
$CurrentValue = (Get-ItemProperty -Path $RegPath -Name $ValueName -ErrorAction SilentlyContinue).$ValueName

If ($null -eq $CurrentValue -or $CurrentValue -lt $DesiredValue) {
    # Set value to DesiredValue if missing or too small
    Set-ItemProperty -Path $RegPath -Name $ValueName -Value $DesiredValue -Type DWord
    Write-Output "Registry updated: $ValueName set to $DesiredValue KB"
}
Else {
    Write-Output "Registry already configured correctly: $ValueName = $CurrentValue KB"
}
 
