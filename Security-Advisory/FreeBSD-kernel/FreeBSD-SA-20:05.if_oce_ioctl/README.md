# FreeBSD-SA-20:05.if_oce_ioctl Postmortem

## Summary

The driver-specific ioctl(2) command handlers in oce(4) failed to check whether the caller has sufficient privileges to perform the corresponding operation.

## Root Causes

* Need `priv_check` before call `oce_handle_passthrough`

## Resolution

* `oce_handle_passthrough` just updates device firmware
* There are no hints that caller should call `priv_check`
* We can't avoid this issue

## File

* sys/dev/oce/oce_if.c
* sys/dev/oce/oce_if.h

## Timeline

### Mon Dec 23 23:43:50 2019 +0000

https://github.com/freebsd/freebsd/commit/94ef8815eec7bb02a0a47a835479b4a141604936

Fixed by markj.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:05.if_oce_ioctl.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-15876
