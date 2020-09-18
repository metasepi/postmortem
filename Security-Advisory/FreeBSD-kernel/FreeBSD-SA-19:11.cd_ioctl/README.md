# FreeBSD-SA-19:11.cd_ioctl Postmortem

## Summary


To implement one particular ioctl, the Linux emulation code used a special interface present in the cd(4) driver which allows it to copy subchannel information directly to a kernel address. This interface was erroneously made accessible to userland, allowing users with read access to a cd(4) device to arbitrarily overwrite kernel memory when some media is present in the device.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/cam/scsi/scsi_cd.c
* sys/compat/linux/linux_ioctl.c
* sys/sys/cdio.h

## Timeline

### Wed Jul 3 00:11:31 2019 UTC

https://svnweb.freebsd.org/base?view=revision&revision=r349628

Fixed by markj.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:11.cd_ioctl.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5602
