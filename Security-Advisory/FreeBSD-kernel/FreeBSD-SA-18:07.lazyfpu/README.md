# FreeBSD-SA-18:07.lazyfpu Postmortem

## Summary

A subset of Intel processors can allow a local thread to infer data from another thread through a speculative execution side channel when Lazy FPU state restore is used.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/amd64/amd64/cpu_switch.S
* sys/amd64/amd64/fpu.c
* sys/i386/i386/swtch.s
* sys/i386/isa/npx.c

## Timeline

xxx

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-18:07.lazyfpu.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-3665
