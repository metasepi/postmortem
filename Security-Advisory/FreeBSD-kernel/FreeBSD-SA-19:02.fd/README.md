# FreeBSD-SA-19:02.fd Postmortem

## Summary

FreeBSD 12.0 attempts to handle the case where the receiving process does not provide a sufficiently large buffer for an incoming control message containing rights.  In particular, to avoid leaking the corresponding descriptors into the receiving process' descriptor table, the kernel handles the truncation case by closing descriptors referenced by the discarded message.

The code which performs this operation failed to release a reference obtained on the file corresponding to a received right.  This bug can be used to cause the reference counter to wrap around and free the file structure.

## Root Causes

* Don't forget `fdrop` to avoid `struct file` leak

## Resolution

* [ATS2 avoid this issue](./Resolution/ATS2)
* [VeriFast avoid this issue](./Resolution/VeriFast)

## File

* sys/kern/uipc_syscalls.c

## Timeline

### Tue Feb 5 17:55:08 2019 +0000

https://github.com/freebsd/freebsd/commit/255362d099e7d3d7e8c1f143974bc1e764163d61

Fixed by markj.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:02.fd.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5596
