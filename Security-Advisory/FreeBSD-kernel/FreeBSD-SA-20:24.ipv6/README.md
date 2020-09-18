# FreeBSD-SA-20:24.ipv6 Postmortem

## Summary

Due to improper mbuf handling in the kernel, a use-after-free bug might be triggered by sending IPv6 Hop-by-Hop options over the loopback interface.

## Root Causes

* `ip6_hopopts_input` function may update `struct mbuf *m` argument with `IP6_EXTHDR_CHECK`
* But the update doesn't return to `ip6_input_hbh` function
* It forces that `ip6_input_hbh` function will use old `struct mbuf *m`

## Resolution

xxx

## File

* sys/netinet6/ip6_input.c

## Timeline

### Thu Sep 19 10:22:29 2019 +0000

https://github.com/freebsd/freebsd/commit/699a34f40f393557f0ad510b11cb72d6b818c35d

Fixed by tuexen.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:24.ipv6.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2020-7462
