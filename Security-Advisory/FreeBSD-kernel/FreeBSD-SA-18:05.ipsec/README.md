# FreeBSD-SA-18:05.ipsec Postmortem

## Summary

The length field of the option header does not count the size of the option header itself.  This causes a problem when the length is zero, the count is then incremented by zero, which causes an infinite loop.

In addition there are pointer/offset mistakes in the handling of IPv4 options.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/netipsec/xform_ah.c

## Timeline

xxx

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-18:05.ipsec.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-6918
