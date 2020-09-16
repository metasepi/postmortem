# FreeBSD-SA-20:06.if_ixl_ioctl Postmortem

## Summary

The driver-specific ioctl(2) command handlers in ixl(4) failed to check whether the caller has sufficient privileges to perform the corresponding operation.

## Root Causes

* Need `priv_check` before call `ixl_handle_nvmupd_cmd`

## Resolution

* `ixl_handle_nvmupd_cmd` just updates device firmware
* There are no hints that caller should call `priv_check`
* We can't avoid this issue

## File

* sys/dev/ixl/if_ixl.c
* sys/dev/ixl/ixl.h

## Timeline

### Thu Jan 2 23:24:57 2020 +0000

https://github.com/freebsd/freebsd/commit/cf3b0bdee1d2f7ec186d9eda3e19bd879887a0c0

Fixed by erj.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:06.if_ixl_ioctl.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-15877
