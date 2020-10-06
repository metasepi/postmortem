# FreeBSD-SA-18:08.tcp Postmortem

## Summary

One of the data structures that holds TCP segments uses an inefficient algorithm to reassemble the data. This causes the CPU time spent on segment processing to grow linearly with the number of segments in the reassembly queue.

## Root Causes

* `tp->t_segqlen` may be too long to be processed

xxx

## Resolution

xxx

## File

* sys/netinet/tcp_reass.c

## Timeline

### Mon Aug 6 17:36:57 2018 +0000

https://github.com/freebsd/freebsd/commit/20a8fc967a377b77768566050bce30a51f91bf2d

Fixed by jtl.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-18:08.tcp.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-6922
