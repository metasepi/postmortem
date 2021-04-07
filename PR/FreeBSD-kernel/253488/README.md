# 253488 – wg(4) IPv6 endpoints not supported yet

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=253488

## Root Causes

* Miss maintain length of IPv6 address
* The `srcsa` and `endpoint` change the size
* `memcpy` and `nvlist_add_binary` should understand the size pointerd from copy source

## Resolution

* At-view or tagged union may be useful
* [ATS2 avoid this issue](./Resolution/ATS2)

## Timeline

### Fri, Feb 26, 1:11 AM

https://reviews.freebsd.org/D28933
