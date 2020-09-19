# FreeBSD-SA-19:06.pf Postmortem

## Summary

States in pf(4) let ICMP and ICMP6 packets pass if they have a packet in their payload matching an existing condition.  pf(4) does not check if the outer ICMP or ICMP6 packet has the same destination IP as the source IP of the inner protocol packet.

## Root Causes

* xxx Only for printf messages?

## Resolution

xxx

## File

* sys/netpfil/pf/pf.c

## Timeline

### Thu Mar 21 08:09:52 2019 +0000

https://github.com/freebsd/freebsd/commit/629163522da88dd4f99f1f0ccae56e221a1a67f8

Fixed by kp.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:06.pf.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5598
