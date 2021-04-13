# 244706 – panic: NULL dereference inside __mtx_lock_sleep()

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=244706

## Root Causes:

* Page fault at `__mtx_lock_sleep`
* It was fixed, but the reason is not clear
* The kgdb shows that `owner` which returns `lv_mtx_owner` has NULL pointer

## Resolution

* xxx At-view and separation logic may avoid NULL dereference on `uintptr_t v`

## Timeline

### Thu Apr  9 15:30:21 2020

https://docs.freebsd.org/cgi/getmsg.cgi?fetch=461841+0+archive/2020/svn-src-stable/20200412.svn-src-stable
