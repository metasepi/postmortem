# FreeBSD-SA-18:10.ip Postmortem

## Summary

A researcher has notified us of a DoS attack applicable to another operating system. While FreeBSD may not be vulnerable to that exact attack, we have identified several places where inadequate DoS protection could allow an attacker to consume system resources.

It is not necessary that the attacker be able to establish two-way communication to carry out these attacks. These attacks impact both IPv4 and IPv6 fragment reassembly.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/netinet/ip_reass.c
* sys/netinet6/frag6.c
* sys/netinet6/in6.h
* sys/netinet6/in6_proto.c
* sys/netinet6/ip6_var.h

## Timeline

xxx

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-18:10.ip.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2018-6923
