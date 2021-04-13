# 252396 – [zfs] [panic] Panic on 'bectl list' after slog removal

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=252396

## Root Causes

* Cause panic at NULL dereference on function pointer

## Resolution

* ATS2 cann't avoid this issue, because view on at-view is not useful
* Separation logic or Rust may avoid NULL dereference

## Timeline

### 2021-02-20 05:57:14 UTC

https://github.com/openzfs/zfs/pull/11623
