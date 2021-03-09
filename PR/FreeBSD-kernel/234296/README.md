# 234296 – FreeBSD 12.0-STABLE r342216 Fatal trap 12

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=234296

## Root Causes

* Page fault at handleevents/softclock/kern_kevent/ip_input/softclock_call_cc
* The location where the page fault occurs is not decided
* We think this issue is not fixed

## Resolution

* None
