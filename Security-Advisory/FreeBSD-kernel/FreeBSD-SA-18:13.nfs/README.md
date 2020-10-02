# FreeBSD-SA-18:13.nfs Postmortem

## Summary

Insufficient and improper checking in the NFS server code could cause a denial of service or possibly remote code execution via a specially crafted network packet.

## Root Causes

* Don't panic, log it (sys/fs/nfs/nfs_commonsubs.c)

xxx

## Resolution

xxx

## File

* sys/fs/nfs/nfs_commonsubs.c
* sys/fs/nfsserver/nfs_nfsdport.c
* sys/fs/nfsserver/nfs_nfsdsocket.c

## Timeline

### Tue Nov 20 01:52:45 2018 +0000

https://github.com/freebsd/freebsd/commit/89ba9a8c9ec4502e7a5d449493c1dacc2dbbddc4

Fixed by rmacklem.

### Tue Nov 20 01:56:34 2018 +0000

https://github.com/freebsd/freebsd/commit/e86dc40415e188fd7b1b72a099411d56fbc88b85

Fixed by rmacklem.

### Tue Nov 20 01:59:57 2018 +0000

https://github.com/freebsd/freebsd/commit/8a42e50bb3788dd0bdc85baa00f44d725c9a51a3

Fixed by rmacklem.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-18:13.nfs.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-17157
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-17158
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-17159
