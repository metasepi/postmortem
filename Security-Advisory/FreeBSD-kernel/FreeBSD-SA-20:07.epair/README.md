# FreeBSD-SA-20:07.epair Postmortem

## Summary

Incorrect use of a potentially user-controlled pointer in the kernel allowed vnet jailed users to panic the system and potentially execute aribitrary code in the kernel.

## Root Causes

```c
void
if_clone_addif(struct if_clone *ifc, struct ifnet *ifp)
{

	if ((ifc->ifc_flags & IFC_NOGROUP) == 0)
		if_addgroup(ifp, ifc->ifc_name);

	IF_CLONE_LOCK(ifc);
	IFC_IFLIST_INSERT(ifc, ifp);
	IF_CLONE_UNLOCK(ifc);
}
// --snip--
static void
epair_clone_add(struct if_clone *ifc, struct epair_softc *scb)
{
	struct ifnet *ifp;
	uint8_t eaddr[ETHER_ADDR_LEN];	/* 00:00:00:00:00:00 */

	ifp = scb->ifp;
	/* Copy epairNa etheraddr and change the last byte. */
	memcpy(eaddr, scb->oifp->if_hw_addr, ETHER_ADDR_LEN);
	eaddr[5] = 0x0b;
	ether_ifattach(ifp, eaddr);

	if_clone_addif(ifc, ifp);
}
// --snip--
static int
epair_clone_create(struct if_clone *ifc, char *name, size_t len, caddr_t params)
{
	struct epair_softc *sca, *scb;
	struct ifnet *ifp;
	char *dp;
	int error, unit, wildcard;
	uint64_t hostid;
	uint32_t key[3];
	uint32_t hash;
	uint8_t eaddr[ETHER_ADDR_LEN];	/* 00:00:00:00:00:00 */
// --snip--
	/* Correctly set the name for the cloner list. */
	strlcpy(name, scb->ifp->if_xname, len); // <= Don't use params which controlled by userspace
	epair_clone_add(ifc, scb);
```

## Resolution

xxx

## File

* sys/net/if_clone.c
* sys/net/if_clone.h
* sys/net/if_epair.c

## Timeline

### Tue Jan 28 22:44:24 2020 +0000

https://github.com/freebsd/freebsd/commit/34cc84f183a6eef7616f351e014aa78f780a8182

Fixed by kp.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:07.epair.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2020-7452
