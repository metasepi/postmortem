# 238741 – [tcp] Using RACK with CDG CC causes connections to hang

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=238741

## Root Causes

* The fetch command timeouts using tcp_rack
* Should use IN_FASTRECOVERY instead of IN_RECOVERY
* Difficult

## Resolution

* None

## Timeline

### 2021-03-02 11:32:16 +0000

https://cgit.freebsd.org/src/commit/?id=99adf230061268175a36061130e6adb0882270e8
