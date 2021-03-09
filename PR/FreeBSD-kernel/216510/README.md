# 216510 – panic while adding an epair to a bridge

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=216510

## Root Causes

* Non-recursive mutex causes panic in `bridge_transmit()`

## Resolution

* xxx Use safe mutex

## Timeline

### Feb 3 2017, 4:38 PM

https://reviews.freebsd.org/D9429
