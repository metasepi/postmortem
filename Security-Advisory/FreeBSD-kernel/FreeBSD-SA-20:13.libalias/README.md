# FreeBSD-SA-20:13.libalias Postmortem

## Summary

The FTP packet handler in libalias incorrectly calculates some packet lengths.  This may result in disclosing small amounts of memory from the kernel (for the in-kernel NAT implementation) or from the process space for natd (for the userspace implementation).

## Root Causes

```c
static void
NewFtpMessage(struct libalias *la, struct ip *pip,
    struct alias_link *lnk,
    int maxpacketsize,
    int ftp_message_type)
{
	struct alias_link *ftp_lnk;
// --snip--
/* Create new FTP message. */
		{
			char stemp[MAX_MESSAGE_SIZE + 1];
			char *sptr;
			u_short alias_port;
			u_char *ptr;
			int a1, a2, a3, a4, p1, p2;
			struct in_addr alias_address;
// --snip--
/* Prepare new command */
			switch (ftp_message_type) {
			case FTP_PORT_COMMAND:
			case FTP_227_REPLY:
				/* Decompose alias port into pair format. */
				ptr = (char *)&alias_port;
				p1 = *ptr++;
				p2 = *ptr;

				if (ftp_message_type == FTP_PORT_COMMAND) {
					/* Generate PORT command string. */
					sprintf(stemp, "PORT %d,%d,%d,%d,%d,%d\r\n",
					    a1, a2, a3, a4, p1, p2);
				} else {
					/* Generate 227 reply string. */
					sprintf(stemp,
					    "227 Entering Passive Mode (%d,%d,%d,%d,%d,%d)\r\n",
					    a1, a2, a3, a4, p1, p2);
				}
				break;
			case FTP_EPRT_COMMAND:
				/* Generate EPRT command string. */
				sprintf(stemp, "EPRT |1|%d.%d.%d.%d|%d|\r\n",
				    a1, a2, a3, a4, ntohs(alias_port));
				break;
			case FTP_229_REPLY:
				/* Generate 229 reply string. */
				sprintf(stemp, "229 Entering Extended Passive Mode (|||%d|)\r\n",
				    ntohs(alias_port));
				break;
			}

/* Save string length for IP header modification */
			slen = strlen(stemp);

/* Copy modified buffer into IP packet. */
			sptr = (char *)pip;
			sptr += hlen;
			strncpy(sptr, stemp, maxpacketsize - hlen);
		}
// --snip--
/* Revise IP header */
		{
			u_short new_len;

			new_len = htons(hlen + slen); // It causes disclosing memory
//			new_len = htons(hlen +
//			    MIN(slen, maxpacketsize - hlen)); // <= The patch to fix it
			DifferentialChecksum(&pip->ip_sum,
			    &new_len,
			    &pip->ip_len,
			    1);
			pip->ip_len = new_len;
		}
```

## Resolution

xxx

## File

* netinet/libalias/alias_ftp.c

## Timeline

### Tue May 12 16:38:28 2020 +0000

https://github.com/freebsd/freebsd/commit/566891527b600a20653bfb359e754a895beedb21

Fixed by emaste.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:13.libalias.asc
* CVE: https://www.cvedetails.com/cve/CVE-2020-7455/
* NVD: https://nvd.nist.gov/vuln/detail/CVE-2020-7455
