# FreeBSD-SA-19:13.pts Postmortem

## Summary

The code which handles a close(2) of a descriptor created by posix_openpt(2) fails to undo the configuration which causes SIGIO to be raised.  This bug can lead to a write-after-free of kernel memory.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/kern/tty.c

## Timeline

### Thu Jul 4 15:42:02 2019 +0000

https://github.com/freebsd/freebsd/commit/7de92ecfe71bf0dc865449a67506a46719e036b2

Fixed by markj.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:13.pts.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5606
