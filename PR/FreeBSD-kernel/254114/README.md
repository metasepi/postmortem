# 254114 - if_wg(4): panic on second ifconfig wg0 up 

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=254114

## Root Causes

* Page fault occurs on `wg_input()`
* The patch is not simple
* Difficult

## Resolution

* None

## Timeline

### 2021-02-27 04:15:04 +0000

https://cgit.freebsd.org/src/commit/?id=9705c012c1f0c7a9ac0f6c8618bebe3e66280a8a
