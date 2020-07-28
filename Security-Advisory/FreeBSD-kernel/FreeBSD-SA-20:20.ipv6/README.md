# FreeBSD-SA-20:20.ipv6 Postmortem

## Summary

The IPV6_2292PKTOPTIONS set handler was missing synchronization, so racing accesses could modify freed memory.

## Root Causes

```c
int
ip6_ctloutput(struct socket *so, struct sockopt *sopt)
{
	int optdatalen, uproto;
	void *optdata;
	struct inpcb *inp = sotoinpcb(so);
	int error, optval;
	int level, op, optname;
	int optlen;
	struct thread *td;
#ifdef	RSS
	uint32_t rss_bucket;
	int retval;
#endif
// --snip--
//				INP_WLOCK(inp); // <= The patch to fix it
				error = ip6_pcbopts(&inp->in6p_outputopts, m,
				    so, sopt); // <= Need INP_WLOCK
//				INP_WUNLOCK(inp); // <= The patch to fix it
// --snip--

static int
ip6_pcbopts(struct ip6_pktopts **pktopt, struct mbuf *m,
    struct socket *so, struct sockopt *sopt)
{
	struct ip6_pktopts *opt = *pktopt;
	int error = 0;
	struct thread *td = sopt->sopt_td;
// --snip--
	if (opt) {
#ifdef DIAGNOSTIC
		if (opt->ip6po_pktinfo || opt->ip6po_nexthop ||
		    opt->ip6po_hbh || opt->ip6po_dest1 || opt->ip6po_dest2 ||
		    opt->ip6po_rhinfo.ip6po_rhi_rthdr)
			printf("ip6_pcbopts: all specified options are cleared.\n");
#endif
		ip6_clearpktopts(opt, -1);
	} else {
		opt = malloc(sizeof(*opt), M_IP6OPT, M_NOWAIT); // <= Forget check NULL
//		if (opt == NULL) // <= The patch to fix it
//			return (ENOMEM);
	}
```

## Resolution

xxx

## File

* sys/netinet6/ip6_output.c

## Timeline

### Thu Mar 19 21:38:52 2020 +0000

https://github.com/freebsd/freebsd/commit/5707de0ed806712f53752acd433313a39f63f15c

Fixed by markj.

## Supporting information

* CVE: https://www.cvedetails.com/cve/CVE-2020-7457/
* NVD: https://nvd.nist.gov/vuln/detail/CVE-2020-7457
