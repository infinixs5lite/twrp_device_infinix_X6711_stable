
recovery-device_itel_P661N_fix
Repository navigation
Code
Pull requests
Actions
recovery-device_itel_P661N_fix/patches
/OTG_PATCHING.md
ardiandideyashidiq
ardiandideyashidiq
4 months ago
168 lines (116 loc) · 3.92 KB

Preview

Code

Blame
OTG Kernel Module Patching Guide
A guide for patching OTG (USB On-The-Go) kernel modules that fail due to missing device tree node lookups.

The Problem
OTG doesn't work on this devices in recovery mode even though the hardware supports it.

Symptoms
tran_otg.ko module loads without errors
But USB OTG functionality doesn't work
No errors in dmesg, or generic "probe failed" messages
Root Cause
The OTG driver calls Linux device tree functions to look up hardware configuration:

of_find_node_opts_by_path() - Find DT node by path
of_find_property() - Find property in DT node
of_get_named_gpio() - Get GPIO from DT
When these lookups fail (node doesn't exist in the device's DTB), the probe function returns an error and OTG never initializes.

Common failing paths:

/chosen@0 - Almost never exists
/chosen - May not exist
Device-specific paths that weren't added to the DTB
The Solution
Instead of modifying the device tree (which requires rebuilding the DTB), patch the kernel module to bypass failing DT lookups.

Target Pattern
The vulnerable code pattern in ARM64:

BL  of_find_node_opts_by_path   ; Call DT lookup function
CBNZ x0, <error_label>        ; Branch if lookup failed (x0=0)
When of_find_node_opts_by_path() fails, it returns 0 (NULL). The CBNZ checks this and jumps to an error handler.

The fix: Replace CBNZ with NOP so the code continues even when the lookup fails.

Byte Replacement
Architecture	Original	Patched	Effect
ARM64	cbnz x0, #offset	nop	Always continue
ARM32	cmp r0, #0 / bne	NOP sequence	Bypass check
For ARM64, the NOP instruction bytes are: 1f 20 03 d5

How to Patch
Method 1: Using dd (Quick)
# Backup original
cp tran_otg.ko tran_otg.ko.bak

# Patch at specific offset (example: 0x1f64)
printf '\x1f\x20\x03\xd5' | dd of=tran_otg.ko bs=1 seek=$((0x1f64)) conv=notrunc
