# FreeBSD-SA-18:01.ipsec Postmortem

## Summary

Due to a lack of strict checking, an attacker from a trusted host can send a specially constructed IP packet that may lead to a system crash.

Additionally, a use-after-free vulnerability in the AH handling code could cause unpredictable results.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/netipsec/xform_ah.c

## Timeline

### Mon Feb 19 11:14:38 2018 +0000

https://github.com/freebsd/freebsd/commit/884abeab5690eefe48c8b19965304acda47884cf

Fixed by ae.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-18:01.ipsec.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-6916
