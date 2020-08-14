# FreeBSD-SA-20:02.ipsec Postmortem

## Summary

A missing check means that an attacker can reinject an old packet and it will be accepted and processed by the IPsec endpoint.

## Root Causes

* Should count up `replay->count` to avoid reinjecting an old packet by attacker

## Resolution

xxx

## File

* sys/netipsec/ipsec.c

## Timeline

### Fri Sep 6 14:30:23 2019 +0000

https://github.com/freebsd/freebsd/commit/c4d20bf3c55ca01953453753119f65d7fb12a0b1

Fixed by fabient.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:02.ipsec.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5613
