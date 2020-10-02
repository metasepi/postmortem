# FreeBSD-SA-18:12.elf Postmortem

## Summary

Insufficient validation was performed in the ELF header parser, and malformed or otherwise invalid ELF binaries were not rejected as they should be.

## Root Causes

* Invalid ELF parser

xxx

## Resolution

xxx

## File

* sys/kern/imgact_elf.c
* sys/kern/vfs_vnops.c

## Timeline

### Wed Sep 12 04:57:34 2018 +0000

https://github.com/freebsd/freebsd/commit/8f599314365b84c03ef0cf6922a02b8a8fce8947

Fixed by gordon.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-18:12.elf.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-6924
