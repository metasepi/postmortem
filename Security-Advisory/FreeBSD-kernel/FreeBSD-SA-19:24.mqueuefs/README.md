# FreeBSD-SA-19:24.mqueuefs Postmortem

## Summary

System calls operating on file descriptors obtain a reference to relevant struct file which due to a programming error was not always put back, which in turn could be used to overflow the counter of affected struct file.

## Root Causes

* Don't forget drop `struct file`

## Resolution

xxx

## File

* sys/kern/uipc_mqueue.c

## Timeline

### Tue Aug 20 17:44:03 2019 +0000

https://github.com/freebsd/freebsd/commit/f555099cb8f204e0e0b079cacc0a81a0012926cb

Fixed by emaste.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:24.mqueuefs.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5603
