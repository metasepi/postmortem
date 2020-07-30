# FreeBSD-SA-20:12.libalias Postmortem

## Summary

libalias(3) packet handlers do not properly validate the packet length before accessing the protocol headers.  As a result, if a libalias(3) module does not properly validate the packet length before accessing the protocol header, it is possible for an out of bound read or write condition to occur.

## Root Causes

* It causes out of bound read or write.

```c
static int
IcmpAliasIn(struct libalias *la, struct ip *pip)
{
	struct icmp *ic;
	int dlen, iresult;

	LIBALIAS_LOCK_ASSERT(la);

//	dlen = ntohs(pip->ip_len) - (pip->ip_hl << 2); // <= The patch to fix it
//	if (dlen < ICMP_MINLEN)
//		return (PKT_ALIAS_IGNORED);
```

## Resolution

xxx

## File

* sys/netinet/libalias/alias.c

## Timeline

### Tue May 12 16:33:04 2020 +0000

https://github.com/freebsd/freebsd/commit/d28ebfbd84ec220d01341d207bc6b22b515fc692

Fixed by emaste.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:12.libalias.asc
* CVE: https://www.cvedetails.com/cve/CVE-2020-7454/
* NVD: https://nvd.nist.gov/vuln/detail/CVE-2020-7454
