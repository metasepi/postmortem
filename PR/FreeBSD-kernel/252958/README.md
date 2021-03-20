# 252958 – [tcp] Kernel panic in tcp_prr_partialack()

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=252958

## Root Causes

* Divide by zero occurs with `recover_fs = 0` on `tcp_prr_partialack()`

## Resolution

* xxx Statically verify right value of division is not zero

## Timeline

### 2021-01-26 15:06:32 +0000

https://cgit.freebsd.org/src/commit/?id=6a376af0cd212be4e16d013d35a0e2eec1dbb8ae
