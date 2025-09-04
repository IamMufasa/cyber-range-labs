<#
.SYNOPSIS
    Enforces STIG requirement WN10-CC-000327 by enabling PowerShell transcription.

.NOTES
    Author          : Richard Akpan
    LinkedIn        : linkedin.com/in/richardakpan/
    GitHub          : github.com/IamMufasa
    Date Created    : 2025-09-03
    Last Modified   : 2025-09-03
    Version         : 1.0
    STIG-ID         : WN10-CC-000327

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run with administrative privileges:
        PS C:\> .\WN10-CC-000327.ps1
#>

# ------------------- PowerShell Script -------------------

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"
If (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }

Set-ItemProperty -Path $RegPath -Name "EnableTranscripting" -Value 1 -Type DWord
Set-ItemProperty -Path $RegPath -Name "OutputDirectory" -Value "C:\Transcripts" -Type String

Write-Output "Policy updated: PowerShell transcription enabled. Logs saved to C:\Transcripts (STIG-compliant)."
