# 253147 – Setting for displaying utf8 characters on all vt consoles results in panic on 14-CURRENT and 13.0-ALPHA3

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=253147

## Root Causes

* `free()` occurs panic
* The `parse_font_info_static` should set `refcount`, not `parse_font_info`

## Resolution

* xxx Statically check `vtozoneslab()` should not return NULL on `slab`

## Timeline

### 2021-01-31 21:04:59 +0000

https://cgit.freebsd.org/src/commit/?id=1912d2b15e6d6f4a1d8c3886b03ab30d2f21f3fd
