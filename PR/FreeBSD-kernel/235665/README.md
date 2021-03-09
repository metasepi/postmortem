# 235665 – panic: handle_written_inodeblock: live inodedep

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=235665

## Root Causes

* `handle_written_inodeblock()` causes panic
* But it is not fundamentally resolved.

## Resolution

* xxx Statically avoid to cause panic
