# FreeBSD-SA-20:14.sctp Postmortem

## Summary

The SCTP layer does improper checking when an application tries to update a shared key.  Therefore an unprivileged local user can trigger a use-after-free situation, for example by specific sequences of updating shared keys and closing the SCTP association.

## Root Causes

* If `skey->deactivated` or `skey->refcount > 1`, the skey can't be replaced
* But the code does replace `skey`, but it doesn't be freed, because `skey->refcount > 1`
* The `skey` may causes use-after-free
* xxx Why need `refcount`?

## Resolution

* [VeriFast avoid this issue](./Resolution/VeriFast)

## File

* sys/netinet/sctp_auth.c

## Timeline

### Tue Sep 17 09:46:42 2019 +0000

https://github.com/freebsd/freebsd/commit/9ba53a7f96928ff33afcd0c934276d03e5125308

Fixed by tuexen.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:14.sctp.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-15878
