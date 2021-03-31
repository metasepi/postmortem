# 205320 – net: incorrect BPF stats

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=205320

## Root Causes

* Did not use no-atomic operator for `u64` type
* Should use `counter_u64_foo()` function for `u64` type
* But the developer can't find that they should use `u64` instead of `u_int64_t`
* Difficult

## Resolution

* None

## Timeline

### Mar 17 2018, 11:35 PM

https://reviews.freebsd.org/D14726
