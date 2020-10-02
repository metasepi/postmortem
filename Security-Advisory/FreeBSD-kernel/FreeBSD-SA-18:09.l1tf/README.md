# FreeBSD-SA-18:09.l1tf Postmortem

## Summary

On certain Intel 64-bit x86 systems there is a period of time during terminal fault handling where the CPU may use speculative execution to try to load data.  The CPU may speculatively access the level 1 data cache (L1D).  Data which would otherwise be protected may then be determined by using side channel methods.

This issue affects bhyve on FreeBSD/amd64 systems.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/amd64/amd64/pmap.c
* sys/amd64/vmm/intel/vmx.c
* sys/amd64/vmm/intel/vmx_genassym.c
* sys/amd64/vmm/intel/vmx_support.S
* sys/x86/include/specialreg.h

## Timeline

xxx

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:02.fd.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5596
