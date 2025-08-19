# Windows 10 STIG Remediation Toolkit

This repository contains **PowerShell scripts** that enforce **DISA STIG (Security Technical Implementation Guide)** requirements for Windows 10.  
Each script automates a specific STIG control and includes documentation for the vulnerability, how to check it, how to fix it, and the script implementation.  

The goal of this project is to build a **modular, repeatable hardening toolkit** for Windows 10 that demonstrates practical security automation.

---

## ✅ Implemented STIGs

### WN10-AC-000005 – Account Lockout Duration
**Vulnerability Discussion:**  
The account lockout feature prevents brute-force password attacks. This parameter specifies how long an account remains locked after repeated failed logon attempts.  

**Check:**  
Navigate to:  
`Computer Configuration → Windows Settings → Security Settings → Account Policies → Account Lockout Policy`  
If **Account lockout duration** is less than 15 minutes (excluding `0`), this is a finding.  

**Fix:**  
Set **Account lockout duration** to **15 minutes or greater**.  
A value of `0` (manual unlock by admin) is also acceptable.  

**Script:** [WN10-AC-000005.ps1](WN10-AC-000005.ps1)  

**Reference:**  
- [STIG-A-View – Windows 10 V3R1](https://stigaview.com/products/win10/v3r1/)  

---

### WN10-AC-000010 – Account Lockout Threshold
**Vulnerability Discussion:**  
Too many failed logon attempts allowed increases the risk of brute-force password attacks.  

**Check:**  
If the **Account lockout threshold** is `0` or greater than `3`, this is a finding.  

**Fix:**  
Set **Account lockout threshold** to **3 invalid attempts or less** (excluding `0`).  

**Script:** [WN10-AC-000010.ps1](WN10-AC-000010.ps1)  

**Reference:**  
- [STIG-A-View – Windows 10 V3R1](https://stigaview.com/products/win10/v3r1/)  

---

### WN10-AC-000020 – Enforce Password History
**Vulnerability Discussion:**  
Without password history enforcement, users can reuse old passwords, defeating the purpose of password changes.  

**Check:**  
If **Enforce password history** is less than `24`, this is a finding.  

**Fix:**  
Configure Windows to remember the last **24 passwords**.  

**Script:** [WN10-AC-000020.ps1](WN10-AC-000020.ps1)  

**Reference:**  
- [STIG-A-View – Windows 10 V3R1](https://stigaview.com/products/win10/v3r1/)  

---

### WN10-AU-000500 – Application Event Log Size
**Vulnerability Discussion:**  
If the Application event log size is too small, it can quickly fill up and overwrite or lose audit events, reducing security visibility.  

**Check:**  
If **Maximum log size (KB)** for the Application log is less than `32,768`, this is a finding.  

**Fix:**  
Set **Maximum log size (KB)** to **32,768 or greater**.  

**Script:** [WN10-AU-000500.ps1](WN10-AU-000500.ps1)  

**Reference:**  
- [STIG-A-View – Windows 10 V3R1](https://stigaview.com/products/win10/v3r1/)  

---

## 🚀 Usage

Run each script with **administrative privileges** on Windows 10. Example:

```powershell
PS C:\> .\WN10-AC-000010.ps1

