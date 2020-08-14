# FreeBSD-SA-20:04.tcp Postmortem

## Summary

When a TCP server transmits or retransmits a TCP SYN-ACK segment over IPv6, the Traffic Class field is not initialized. This also applies to challenge ACK segments, which are sent in response to received RST segments during the TCP connection setup phase.

## Root Causes

```c
static int
syncache_respond(struct syncache *sc, const struct mbuf *m0, int flags)
{
	struct ip *ip = NULL;
	struct mbuf *m;
	struct tcphdr *th = NULL;
	int optlen, error = 0;	/* Make compiler happy */
	u_int16_t hlen, tlen, mssopt;
	struct tcpopt to;
#ifdef INET6
	struct ip6_hdr *ip6 = NULL;
#endif
// --snip--
	/* Create the IP+TCP header from scratch. */
	m = m_gethdr(M_NOWAIT, MT_DATA);
	if (m == NULL)
		return (ENOBUFS);
// --snip--
#ifdef INET6
	if (sc->sc_inc.inc_flags & INC_ISIPV6) {
		ip6 = mtod(m, struct ip6_hdr *);
		ip6->ip6_vfc = IPV6_VERSION;
		ip6->ip6_nxt = IPPROTO_TCP;
		ip6->ip6_src = sc->sc_inc.inc6_laddr;
		ip6->ip6_dst = sc->sc_inc.inc6_faddr;
		ip6->ip6_plen = htons(tlen - hlen);
		/* ip6_hlim is set after checksum */
		/* Zero out traffic class and flow label. */
		ip6->ip6_flow &= ~IPV6_FLOWINFO_MASK; // <= Should hide only 1 byte
		ip6->ip6_flow |= sc->sc_flowlabel;
```

## Resolution

xxx

## File

* sys/netinet/tcp_syncache.c

## Timeline

### Wed Mar 4 12:22:53 2020 +0000

https://github.com/freebsd/freebsd/commit/cfddb2fdaa08b2a3ad2c74c045c2a1171b280c31

Fixed by tuexen.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:04.tcp.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2020-7451
