# 248065 – Linuxulator: 32-bit compat + send with MSG_NOSIGNAL

## Summary

* https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=248065

## Root Causes

* Could return spurious EAGAIN for non-blocking sockets
* Need to convert between `bsd_args.flags` and `args->flags`

## Resolution

* Introduce different type onto the flags
* [ATS2 avoid this issue](./Resolution/ATS2)

## Timeline

### Fri, Feb 5, 5:26 PM

https://reviews.freebsd.org/D28504
