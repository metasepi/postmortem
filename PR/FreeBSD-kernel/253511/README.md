# 253511 – vm.pmap.pg_ps_enabled=0 and kern.elf64.aslr.enable=1 panics with integer divide by zero

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=253511

## Root Causes

* Divide by zero occurs with `align = 0`

## Resolution

* Statically verify right value of division is not zero
* [ATS2 avoid this issue](./Resolution/ATS2)

## Timeline

### Mon, Feb 15, 3:08 AM

https://reviews.freebsd.org/D28678
