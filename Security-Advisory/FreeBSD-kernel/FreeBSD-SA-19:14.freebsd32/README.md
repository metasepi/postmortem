# FreeBSD-SA-19:14.freebsd32 Postmortem

## Summary

Due to insufficient initialization of memory copied to userland in the components listed above small amounts of kernel memory may be disclosed to userland processes.

## Root Causes

* Clear the entire `pmc` and `pc32` struct to avoid kernel stack data leak
* It's caused by uninitialized value

## Resolution

* [ATS2 avoid this issue](./Resolution/ATS2)
* VeriFast can't avoid this issue

## File

* sys/compat/freebsd32/freebsd32_ioctl.c

## Timeline

### Mon Jul 22 18:14:34 2019 +0000

https://github.com/freebsd/freebsd/commit/434d0d10e85bc9187b363d8f246acfc143466444

Fixed by emaste.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:14.freebsd32.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5605
