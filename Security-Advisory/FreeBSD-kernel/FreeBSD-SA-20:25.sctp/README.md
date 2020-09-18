# FreeBSD-SA-20:25.sctp Postmortem

## Summary

Due to improper handling in the kernel, a use-after-free bug can be triggered by sending large user messages from multiple threads on the same socket.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/netinet/sctp_input.c
* sys/netinet/sctp_output.c
* sys/netinet/sctp_pcb.c
* sys/netinet/sctp_structs.h
* sys/netinet/sctputil.c
* sys/netinet/sctputil.h

## Timeline

xxx Should find more patches

### Sun Aug 16 11:50:37 2020 +0000

https://github.com/freebsd/freebsd/commit/a62795a30ffc71cb6991d0717cba2da86de45fba

Fixed by tuexen.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:25.sctp.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2020-7463
