# FreeBSD-SA-19:07.mds Postmortem

## Summary

On some Intel processors utilizing speculative execution a local process may be able to infer stale information from microarchitectural buffers to obtain a memory disclosure.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/amd64/amd64/exception.S
* sys/amd64/amd64/genassym.c
* sys/amd64/amd64/initcpu.c
* sys/amd64/amd64/machdep.c
* sys/amd64/amd64/support.S
* sys/amd64/include/pcpu.h
* sys/dev/cpuctl/cpuctl.c
* sys/i386/i386/exception.s
* sys/i386/i386/genassym.c
* sys/i386/i386/initcpu.c
* sys/i386/i386/support.s
* sys/i386/include/pcpu.h
* sys/x86/include/specialreg.h
* sys/x86/include/x86_var.h
* sys/x86/x86/cpu_machdep.c

## Timeline

### Tue May 14 17:02:20 2019 +0000

https://github.com/freebsd/freebsd/commit/92e7c0f46ef2223c56b362a00cad99f1e390d9ce

Fixed by kib.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:07.mds.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-12126
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-12127
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-12130
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-11091
