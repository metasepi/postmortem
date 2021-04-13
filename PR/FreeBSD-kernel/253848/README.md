# 253848 – [tcp] panic: sackhint bytes rtx >= 0

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=253848

## Root Causes

* KASSERT occurs panic in `tcp_sack_doack()`
* Miss initialize `tp->sackhint.sack_bytes_rexmit = 0`
* But the initialization is the root cause?
* Difficult to prove invariant `while (sblkp >= sack_blocks && cur != NULL)`

## Resolution

* None

## Timeline

### Fri, Mar 5, 3:13 PM

https://reviews.freebsd.org/D29083
