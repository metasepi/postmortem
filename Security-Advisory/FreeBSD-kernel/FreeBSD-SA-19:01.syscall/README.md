# FreeBSD-SA-19:01.syscall Postmortem

## Summary

The callee-save registers are used by kernel and for some of them (%r8, %r10, and for non-PTI configurations, %r9) the content is not sanitized before return from syscalls, potentially leaking sensitive information.

## Root Causes

xxx

## Resolution

* We can't avoid this issue on assembler implementation

## File

* sys/amd64/amd64/exception.S

## Timeline

### Tue Feb 5 17:49:27 2019 +0000

https://github.com/freebsd/freebsd/commit/84203fed6bace55a9e7f89d83cf74bd81603e91e

Fixed by kib.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:01.syscall.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5595
