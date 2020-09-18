# FreeBSD-SA-20:28.bhyve_vmcs Postmortem

## Summary

AMD and Intel CPUs support hardware virtualization using specialized data structures that control various aspects of guest operation.  These are the Virtual Machine Control Structure (VMCS) on Intel CPUs, and the Virtual Machine Control Block (VMCB) on AMD CPUs.  Insufficient access controls allow root users, including those running in a jail, to change these data structures.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/amd64/vmm/amd/svm.c
* sys/amd64/vmm/intel/vmx.c

## Timeline

### Tue Sep 15 21:04:27 2020 +0000

https://github.com/freebsd/freebsd/commit/632a0fb8d3cb27b2ebb313e157bd9d44fb300660

Fixed by emaste.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:28.bhyve_vmcs.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2020-24718
