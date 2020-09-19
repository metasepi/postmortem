# FreeBSD-SA-19:10.ufs Postmortem

## Summary

A bug causes up to three bytes of kernel stack memory to be written to disk as uninitialized directory entry padding.  This data can be viewed by any user with read access to the directory.  Additionally, a malicious user with write access to a directory can cause up to 254 bytes of kernel stack memory to be exposed.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/ufs/ufs/dir.h
* sys/ufs/ufs/ufs_lookup.c

## Timeline

### Fri May 3 21:46:25 2019 +0000

https://github.com/freebsd/freebsd/commit/e28330c77bd43f2c59e84e897ab6595fd821cbb5

Fixed by mckusick.

### Fri May 3 21:54:14 2019 +0000

https://github.com/freebsd/freebsd/commit/c4824e67f54b25d500b4371e14f62df3882f2f5e

Fixed by mckusick.

### Sat May 4 18:00:57 2019 +0000

https://github.com/freebsd/freebsd/commit/54d65ae934e9e1151b2eef97a0bc83a5318c4187

Fixed by mckusick.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:10.ufs.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5601
