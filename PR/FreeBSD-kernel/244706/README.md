# 244706 – panic: NULL dereference inside __mtx_lock_sleep()

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=244706

## Root Causes:

* Page fault at `__mtx_lock_sleep`
* It was fixed, but the reason is not clear

## Resolution

* xxx At-view and separation logic may avoid miss dereference
