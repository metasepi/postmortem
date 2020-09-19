# FreeBSD-SA-19:08.rack Postmortem

## Summary

While processing acknowledgements, the RACK code uses several linked lists to maintain state entries.  A malicious attacker can cause the lists to grow unbounded.  This can cause an expensive list traversal on every packet being processed, leading to resource exhaustion and a denial of service.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/netinet/tcp_stacks/rack.c
* sys/netinet/tcp_stacks/tcp_rack.h

## Timeline

### Wed Jun 19 13:55:00 2019 +0000

https://github.com/freebsd/freebsd/commit/a21d319b29eb5bb593169220848d48e61cb01ba5

Fixed by jtl.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:08.rack.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5599
