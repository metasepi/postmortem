# 253061 – sys/net/if_vlan:qinq_deep test triggers "UNR: free_unr(3735929054) out of range" panic

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=253061

## Root Causes

* KASSERT occurs panic in `free_unrl()`

## Resolution

* Statically check KASSERT
* [ATS2 avoid this issue](./Resolution/ATS2)

## Timeline

### Dec 7 2020, 11:35 PM

https://reviews.freebsd.org/D27505
