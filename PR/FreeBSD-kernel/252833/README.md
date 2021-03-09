# 252833 – panic changing vt font with gfx-enabled EFI loader

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=252833

## Root Causes

* `free()` occurs panic
* Need to set `refcount`
* And this causes PR 253147

## Resolution

* xxx Statically check `vtozoneslab()` should not return NULL on `slab`

## Timeline

### 2021-01-24 18:59:36 +0000

https://cgit.freebsd.org/src/commit/?id=93ebd6307efeb95a29bc614edd0c67c2af850e98
