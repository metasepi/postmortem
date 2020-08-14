# FreeBSD-SA-19:22.mbuf Postmortem

## Summary

Due do a missing check in the code of m_pulldown(9) data returned may not be contiguous as requested by the caller.

## Root Causes

* The next mbuf should have length greater than or equal to `tlen`

## Resolution

xxx

## File

* sys/kern/uipc_mbuf2.c

## Timeline

### Fri Aug 9 05:18:59 2019 +0000

https://github.com/freebsd/freebsd/commit/6e852342e4efda458ed0e89c5a70298bc75b1ae7

Fixed by jtl.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:22.mbuf.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5611
