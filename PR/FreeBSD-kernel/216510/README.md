# 216510 – panic while adding an epair to a bridge

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=216510

## Root Causes

* `EVENTHANDLER_INVOKE(iflladdr_event, sc->sc_ifp)` will call `bridge_transmit()`?
* Callers of `bridge_delete_member()` and `bridge_ioctl_add()` call `BRIDGE_LOCK(sc)`
* `bridge_transmit()` also calls `BRIDGE_LOCK(sc)`
* Non-recursive mutex causes panic in `bridge_transmit()`

## Resolution

* xxx Use safe mutex

## Timeline

### Feb 3 2017, 4:38 PM

https://reviews.freebsd.org/D9429
