# 253541 – if_wg(4): panic on wireguard interface destroy

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=253541

## Root Causes

* Page fault when ifconfig wg0 destroy
* `iflib_pseudo_detach()` should not call `IFDI_DETACH()`
* Difficult, because we can't find the code of `IFDI_DETACH()`

## Resolution

* None

## Timeline

### Thu, Feb 18, 3:07 PM

https://reviews.freebsd.org/D28774
