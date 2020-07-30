# FreeBSD-SA-20:10.ipfw Postmortem

## Summary

Incomplete packet data validation may result in accessing out-of-bounds memory (CVE-2019-5614) or may access memory after it has been freed (CVE-2019-15874).

## Root Causes

xxx

## Resolution

xxx

## File

* sys/netpfil/ipfw/ip_fw2.c

## Timeline

### Mon Jul 29 12:55:48 2019 +0000

https://github.com/freebsd/freebsd/commit/aaf6f1c4ac7400dd33dbb73468a9c9757c70ddf5

Fixed by ae.

### Tue Dec 10 10:35:32 2019 +0000

https://github.com/freebsd/freebsd/commit/6dfdda7982f0400062dd568dcd09dd13e1b8b26e

Fixed by ae.

### Fri Dec 13 11:47:58 2019 +0000

https://github.com/freebsd/freebsd/commit/5d1408ea62965656d549041757c6ae2557ff54eb

Fixed by ae.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:10.ipfw.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5614
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-15874
