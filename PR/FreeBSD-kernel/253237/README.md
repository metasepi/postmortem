# 253237 - sys/netgraph/ng_macfilter_test:main test panics on RISC-V QEMU 

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=253237

## Root Causes

* Page fault occurs on `witness_checkorder()`
* It caused by miss alias atomic function
* Hard to prove atomic function statically

## Resolution

* None

## Timeline

### Thu, Mar 4, 6:04 PM

https://reviews.freebsd.org/D29064
