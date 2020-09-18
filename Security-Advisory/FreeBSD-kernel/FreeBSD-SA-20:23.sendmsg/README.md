# FreeBSD-SA-20:23.sendmsg Postmortem

## Summary

When handling a 32-bit sendmsg(2) call, the compat32 subsystem copies the control message to be transmitted (if any) into kernel memory, and adjusts alignment of control message headers.  The code which performs this work contained a time-of-check to time-of-use (TOCTOU) vulnerability which allows a malicious userspace program to modify control message headers after they were validated by the kernel.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/compat/freebsd32/freebsd32_misc.c

## Timeline

### Wed Aug 5 17:06:14 2020 +0000

https://github.com/freebsd/freebsd/commit/3846ff841491a990212681f423ac8e26c39032b9

Fixed by markj.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:23.sendmsg.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2020-7460
