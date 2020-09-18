# FreeBSD-SA-20:27.ure Postmortem

## Summary

A programming error in the ure(4) device driver caused some Realtek USB Ethernet interfaces to incorrectly report packets with more than 2048 bytes in a single USB transfer as having a length of only 2048 bytes.

An adversary can exploit this to cause the driver to misinterpret part of the payload of a large packet as a separate packet, and thereby inject packets across security boundaries such as VLANs.

## Root Causes

* Miss setting on `URE_PLA_RCR` register of RealTek device

## Resolution

* We can't avoid this issue

## File

* sys/dev/usb/net/if_ure.c

## Timeline

### Fri Sep 11 02:02:13 2020 +0000

https://github.com/freebsd/freebsd/commit/aa34c93d38c3f3dcef5a91fb30da58158146ccfa

Fixed by jmg.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:27.ure.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2020-7464
