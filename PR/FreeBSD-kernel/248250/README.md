# 248250 – Witness Warning: 'Exclusive Sleep Mutex vtdev locked' warning on arm64 (RPi4b)

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=248250

## Root Causes

* `uma_zalloc(M_WAITOK)` causes WITNESS warning
* Can't statically check `witness_warn()`, because the `flags` is passed dynamically
* Difficult

## Resolution

* None

## Timeline

### Aug 9 2020, 8:30 AM

https://reviews.freebsd.org/D26010
