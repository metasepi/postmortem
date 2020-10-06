# FreeBSD-SA-18:04.vt Postmortem

## Summary

Insufficient validation of user-provided font parameters can result in an integer overflow, leading to the use of arbitrary kernel memory as glyph data.  Characters that reference this data can be displayed on the screen, effectively disclosing kernel memory.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/dev/vt/vt_font.c

## Timeline

### Wed Apr 4 05:21:46 2018 +0000

https://github.com/freebsd/freebsd/commit/44adf367dc37489a9d01a3cb032c316042464e2d

Fixed by gordon.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-18:04.vt.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-6917
