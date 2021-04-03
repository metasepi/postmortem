# 253272 – Page fault in _mca_init during boot

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=253272

## Root Causes

* `cmci_monitor()` accesses global value `cmc_state` which is NULL
* Hard to check NULL on global value statically
* Difficult

## Resolution

* None

## Timeline

### 2021-02-08 19:42:54 +0000

https://cgit.freebsd.org/src/commit/?id=b5770470276268acef21368b3e77a325df883500
