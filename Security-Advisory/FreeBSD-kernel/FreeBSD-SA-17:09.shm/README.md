# FreeBSD-SA-17:09.shm Postmortem

## Summary

Named paths are globally scoped, meaning a process located in one jail can read and modify the content of POSIX shared memory objects created by a process in another jail or the host system.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/kern/uipc_mqueue.c
* sys/kern/uipc_sem.c
* sys/kern/uipc_shm.c

## Timeline

xxx

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-17:09.shm.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2017-1087
