# FreeBSD-SA-20:08.jail Postmortem

## Summary

A missing NUL-termination check for the jail_set(2) configration option "osrelease" may return more bytes when reading the jail configuration back with jail_get(2) than were originally set.

## Root Causes

```c
int
kern_jail_set(struct thread *td, struct uio *optuio, int flags)
{
	struct nameidata nd;
#ifdef INET
	struct in_addr *ip4;
#endif
#ifdef INET6
	struct in6_addr *ip6;
#endif
	struct vfsopt *opt;
	struct vfsoptlist *opts;
	struct prison *pr, *deadpr, *mypr, *ppr, *tpr;
	struct vnode *root;
	char *domain, *errmsg, *host, *name, *namelc, *p, *path, *uuid;
	char *g_path, *osrelstr;
	struct bool_flags *bf;
	struct jailsys_flags *jsf;
#if defined(INET) || defined(INET6)
	struct prison *tppr;
	void *op;
#endif
	unsigned long hid;
	size_t namelen, onamelen, pnamelen;
	int born, created, cuflags, descend, enforce;
	int error, errmsg_len, errmsg_pos;
	int gotchildmax, gotenforce, gothid, gotrsnum, gotslevel;
	int jid, jsys, len, level;
	int childmax, osreldt, rsnum, slevel;
#if defined(INET) || defined(INET6)
	int ii, ij;
#endif
#ifdef INET
	int ip4s, redo_ip4;
#endif
#ifdef INET6
	int ip6s, redo_ip6;
#endif
	uint64_t pr_allow, ch_allow, pr_flags, ch_flags;
	uint64_t pr_allow_diff;
	unsigned tallow;
	char numbuf[12];
// --snip--
	error = vfs_getopt(opts, "osrelease", (void **)&osrelstr, &len);
// --snip--
		if (len == 0 || osrelstr[len - 1] != '\0') { // <= NUL-termination check
			error = EINVAL;
			goto done_free;
		}
		if (len >= OSRELEASELEN) {
			error = ENAMETOOLONG;
			vfs_opterror(opts,
			    "osrelease string must be 1-%d bytes long",
			    OSRELEASELEN - 1);
			goto done_errmsg;
		}
// --snip--
		if (osrelstr == NULL)
			strlcpy(pr->pr_osrelease, ppr->pr_osrelease,
			    sizeof(pr->pr_osrelease)); // <= Use strlcpy to avoid reading kernel memory
		else
			strlcpy(pr->pr_osrelease, osrelstr,
			    sizeof(pr->pr_osrelease));
```

## Resolution

xxx

## File

* sys/kern/kern_jail.c

## Timeline

### Sat Mar 14 14:04:55 2020 +0000

https://github.com/freebsd/freebsd/commit/c35d205d229a0189f8a1855fa46651dd25d91509

Fixed by bz.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:08.jail.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2020-7453
