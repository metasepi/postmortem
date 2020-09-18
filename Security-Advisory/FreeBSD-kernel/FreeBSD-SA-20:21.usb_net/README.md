# FreeBSD-SA-20:21.usb_net Postmortem

## Summary

A missing length validation code common to these three drivers means that a malicious USB device could write beyond the end of an allocated network packet buffer.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/dev/usb/net/if_cdceem.c
* sys/dev/usb/net/if_muge.c
* sys/dev/usb/net/if_smsc.c

## Timeline

### Thu Jun 11 14:31:51 2020 +0000

https://github.com/freebsd/freebsd/commit/07e65b3d9694a474db157bfabe66e4b1704ef5a7

Fixed by hselasky.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:21.usb_net.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2020-7459
