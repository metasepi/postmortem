# FreeBSD-SA-17:10.kldstat Postmortem

## Summary

The kernel does not properly clear the memory of the kld_file_stat structure before filling the data.  Since the structure filled by the kernel is allocated on the kernel stack and copied to userspace, a leak of information from the kernel stack is possible.

## Root Causes

* Clear the entire kld_file_stat struct to avoid kernel stack data leak
* It's caused by uninitialized value

## Resolution

* [ATS2 avoid this issue](./Resolution/ATS2)
* VeriFast can't avoid this issue

## File

* sys/compat/freebsd32/freebsd32_misc.c
* sys/kern/kern_linker.c

## Timeline

### Wed Nov 15 22:30:21 2017 +0000

https://github.com/freebsd/freebsd/commit/2d36b76cdfe2dbdc3096b26125e43716b3a5039b

Fixed by gordon.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-17:10.kldstat.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2017-1088
