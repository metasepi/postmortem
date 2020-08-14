# FreeBSD-SA-19:17.fd Postmortem

## Summary

If a process attempts to transmit rights over a UNIX-domain socket and an error causes the attempt to fail, references acquired on the rights are not released and are leaked.  This bug can be used to cause the reference counter to wrap around and free the corresponding file structure.

## Root Causes

* Don't forget to free `struct filedescent`s

## Resolution

xxx

## File

* sys/kern/uipc_usrreq.c

## Timeline

### Fri Jul 19 20:51:39 2019 +0000

https://github.com/freebsd/freebsd/commit/ab87bfcd7a0fae8233e897d901ba9c510d26d425

Fixed by kib.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:17.fd.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5607
