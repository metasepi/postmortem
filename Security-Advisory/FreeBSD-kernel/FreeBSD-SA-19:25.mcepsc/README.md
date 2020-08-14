# FreeBSD-SA-19:25.mcepsc Postmortem

## Summary

Intel discovered a previously published erratum on some Intel platforms can be exploited by malicious software to potentially cause a denial of service by triggering a machine check that will crash or hang the system.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/amd64/amd64/pmap.c
* sys/amd64/include/pmap.h
* sys/dev/cpuctl/cpuctl.c
* sys/x86/include/specialreg.h

## Timeline

### Tue Nov 12 18:01:33 2019 +0000

https://github.com/freebsd/freebsd/commit/f6d654668444e91f19d16eb2a5ee952941e85cf5

Fixed by kib.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:25.mcepsc.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-12207
