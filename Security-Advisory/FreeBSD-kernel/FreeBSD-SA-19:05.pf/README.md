# FreeBSD-SA-19:05.pf Postmortem

## Summary

A bug in the pf(4) IPv6 fragment reassembly logic incorrectly uses the last extension header offset from the last received packet instead of from the first packet.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/netpfil/pf/pf_norm.c

## Timeline

### Fri Mar 1 07:37:45 2019 +0000

https://github.com/freebsd/freebsd/commit/c674ede188217fc19c9063cbcfa79d2639a033d7

Fixed by kp.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:05.pf.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5597
