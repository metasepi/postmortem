# FreeBSD-SA-20:14.sctp Postmortem

## Summary

The SCTP layer does improper checking when an application tries to update a shared key.  Therefore an unprivileged local user can trigger a use-after-free situation, for example by specific sequences of updating shared keys and closing the SCTP association.

## Root Causes

```c
int
sctp_insert_sharedkey(struct sctp_keyhead *shared_keys,
    sctp_sharedkey_t *new_skey)
{
	sctp_sharedkey_t *skey;

	if ((shared_keys == NULL) || (new_skey == NULL))
		return (EINVAL);

	/* insert into an empty list? */
	if (LIST_EMPTY(shared_keys)) {
		LIST_INSERT_HEAD(shared_keys, new_skey, next);
		return (0);
	}
	/* insert into the existing list, ordered by key id */
	LIST_FOREACH(skey, shared_keys, next) {
		if (new_skey->keyid < skey->keyid) {
			/* insert it before here */
			LIST_INSERT_BEFORE(skey, new_skey, next);
			return (0);
		} else if (new_skey->keyid == skey->keyid) {
			/* replace the existing key */
			/* verify this key *can* be replaced */
			if ((skey->deactivated) || (skey->refcount > 1)) { // <= The patch to fix it
				SCTPDBG(SCTP_DEBUG_AUTH1,
				    "can't replace shared key id %u\n",
				    new_skey->keyid);
				return (EBUSY);
			}
			SCTPDBG(SCTP_DEBUG_AUTH1,
			    "replacing shared key id %u\n",
			    new_skey->keyid);
			LIST_INSERT_BEFORE(skey, new_skey, next);
			LIST_REMOVE(skey, next);
			sctp_free_sharedkey(skey); // <= May cause use-after-free
			return (0);
		}
```

## Resolution

xxx

## File

* sys/netinet/sctp_auth.c

## Timeline

### Tue Sep 17 09:46:42 2019 +0000

https://github.com/freebsd/freebsd/commit/9ba53a7f96928ff33afcd0c934276d03e5125308

Fixed by tuexen.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:14.sctp.asc
* CVE: https://www.cvedetails.com/cve/CVE-2019-15878/
* NVD: https://nvd.nist.gov/vuln/detail/CVE-2019-15878
