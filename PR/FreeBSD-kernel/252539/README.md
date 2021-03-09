# 252539 – [PATCH] kevent(2): wrong EVFILT_TIMER timeouts when using NOTE_NSECONDS

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=252539

## Root Causes

* Miss use a function to change unit of time

## Resolution

* xxx Add static type to return value has unit of time

## Timeline

### Jan 9 2021, 5:42 PM

https://reviews.freebsd.org/D28067
