# 254229 - Kernel panic when connect USB mass storage on Raspberry Pi 4

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=254229

## Root Causes

* Causes panic "malloc(M_WAITOK) with sleeping prohibited" at `malloc_dbg()`
* KASSERT occurs panic in `malloc_dbg()`

## Resolution

* xxx Statically check KASSERT. But it may be hard

## Timeline

### Wed, Mar 10, 11:06 PM

https://reviews.freebsd.org/D29210
