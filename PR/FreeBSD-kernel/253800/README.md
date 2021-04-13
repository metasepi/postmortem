# 253800 – [panic] FreeBSD-13.0 (releng/13.0) panic upon duplicate IPv4 detection / page fault while in kernel mode (in function rtsock_routemsg_info)

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=253800

## Root Causes

* Page fault at boot
* Miss memmory access at `rtsock_routemsg`
* Following patches fixed this issue?
* Following `rt` argument may be NULL

```c
int rtsock_routemsg(int cmd, struct rtentry *rt, struct nhop_object *nh, int fibnum)
```

* It's caused by `rib_action` failing and dereferencing `rc.rc_rt`

## Resolution

* ATS2 cann't avoid this issue, because view on at-view is not useful
* Separation logic or Rust may avoid page fault

## Timeline

### 2021-02-23 22:31:07 +0000

https://cgit.freebsd.org/src/commit/?id=9c4a8d24f0ffd5243fa5c6fe27178f669f16d1f5

### 2021-02-24 16:42:48 +0000

https://cgit.freebsd.org/src/commit/?id=cc3fa1e29fda2cc761e793a61cef3bd2522b3468
