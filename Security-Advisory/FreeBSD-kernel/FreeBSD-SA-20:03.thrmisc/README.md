# FreeBSD-SA-20:03.thrmisc Postmortem

## Summary

Due to incorrect initialization of a stack data structure, up to 20 bytes of kernel data stored previously stored on the stack will be exposed to a crashing user process.

## Root Causes

* Clear the entire thrmisc struct to avoid kernel stack data leak

## Resolution

xxx

## File

* sys/kern/imgact_elf.c

## Timeline

### Thu Oct 31 20:42:36 2019 +0000

https://github.com/freebsd/freebsd/commit/685a165c4c0b975cb2819b7042e1ddbc6eb79c5d

Fixed by emaste.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:03.thrmisc.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-15875
