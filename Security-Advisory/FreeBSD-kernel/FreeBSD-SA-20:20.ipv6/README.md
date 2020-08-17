# FreeBSD-SA-20:20.ipv6 Postmortem

## Summary

The IPV6_2292PKTOPTIONS set handler was missing synchronization, so racing accesses could modify freed memory.

## Root Causes

* Should lock `struct inpcb` if you modify the struct on `ip6_pcbopts` function

## Resolution

xxx

## File

* sys/netinet6/ip6_output.c

## Timeline

### Thu Mar 19 21:38:52 2020 +0000

https://github.com/freebsd/freebsd/commit/5707de0ed806712f53752acd433313a39f63f15c

Fixed by markj.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:20.ipv6.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2020-7457
