# FreeBSD-SA-20:29.bhyve_svm Postmortem

## Summary

A number of AMD virtualization instructions operate on host physical addresses, are not subject to nested page table translation, and guest use of these instructions was not trapped.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/amd64/vmm/amd/svm.c
* sys/amd64/vmm/amd/vmcb.h

## Timeline

### Tue Sep 15 20:22:50 2020 +0000

https://github.com/freebsd/freebsd/commit/d710e43fb9cdd2e288965e7760e7936b4addbadb

Fixed by kib.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:29.bhyve_svm.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2020-7467
