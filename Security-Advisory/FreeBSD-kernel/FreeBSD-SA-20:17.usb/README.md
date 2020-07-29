# FreeBSD-SA-20:17.usb Postmortem

## Summary

If the push/pop level is not restored within the processing of the same HID item, an invalid memory location may be used for subsequent HID item processing.

## Root Causes

```c
int
hid_get_item(struct hid_data *s, struct hid_item *h)
{
	struct hid_item *c;
	unsigned int bTag, bType, bSize;
	uint32_t oldpos;
	int32_t mask;
	int32_t dval;
// --snip--
			case 10:	/* Push */
				/* stop parsing, if invalid push level */
				if ((s->pushlevel + 1) >= MAXPUSH) {
					DPRINTFN(0, "Cannot push item @ %d\n", s->pushlevel);
					return (0); // <= Should stop parsing
				}
				s->pushlevel ++;
				s->cur[s->pushlevel] = *c;
				/* store size and count */
				c->loc.size = s->loc_size;
				c->loc.count = s->loc_count;
				/* update current item pointer */
				c = &s->cur[s->pushlevel];
				break;
			case 11:	/* Pop */
				/* stop parsing, if invalid push level */
				if (s->pushlevel == 0) {
					DPRINTFN(0, "Cannot pop item @ 0\n");
					return (0); // <= Should stop parsing
				}
				s->pushlevel --;
				/* preserve position */
				oldpos = c->loc.pos;
				c = &s->cur[s->pushlevel];
				/* restore size and count */
				s->loc_size = c->loc.size;
				s->loc_count = c->loc.count;
				/* set default item location */
				c->loc.pos = oldpos;
				c->loc.size = 0;
				c->loc.count = 0;
				break;
```

## Resolution

xxx

## File

* lib/libusbhid/parse.c
* sys/dev/usb/usb_hid.c

## Timeline

### Fri Jun 5 07:57:16 2020 +0000

https://github.com/freebsd/freebsd/commit/83f4a222f097d1d4eea16e165fa7ac8b3efe63a4

Fixed by hselasky.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-20:17.usb.asc
* CVE: https://www.cvedetails.com/cve/CVE-2020-7456/
* NVD: https://nvd.nist.gov/vuln/detail/CVE-2020-7456
