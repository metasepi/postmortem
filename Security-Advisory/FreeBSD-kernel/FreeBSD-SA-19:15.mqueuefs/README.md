# FreeBSD-SA-19:15.mqueuefs Postmortem

## Summary

System calls operating on file descriptors obtain a reference to relevant struct file which due to a programming error was not always put back, which in turn could be used to overflow the counter of affected struct file.

## Root Causes

* Don't forget `fdrop` to avoid `struct file` leak

## Resolution

* [ATS2 avoid this issue](./Resolution/ATS2)
* [VeriFast avoid this issue](./Resolution/VeriFast)

## File

* sys/kern/uipc_mqueue.c

## Timeline

### Tue Jul 23 20:59:36 2019 +0000

https://github.com/freebsd/freebsd/commit/feb038e4b4cec89f24f3a23da2d69e3d1e741cc5

Fixed by emaste.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:15.mqueuefs.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5603
