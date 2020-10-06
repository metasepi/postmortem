# FreeBSD-SA-18:06.debugreg Postmortem

## Summary

The MOV SS and POP SS instructions inhibit debug exceptions until the instruction boundary following the next instruction.  If that instruction is a system call or similar instruction that transfers control to the operating system, the debug exception will be handled in the kernel context instead of the user context.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/amd64/amd64/exception.S
* sys/amd64/amd64/machdep.c
* sys/amd64/amd64/mp_machdep.c
* sys/amd64/amd64/pmap.c
* sys/amd64/amd64/trap.c
* sys/i386/i386/trap.c

## Timeline

xxx

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-18:06.debugreg.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-8897
