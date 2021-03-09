# 253848 – [tcp] panic: sackhint bytes rtx >= 0

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=253848

## Root Causes

* KASSERT occurs panic in `tcp_sack_doack()`
* Miss initialize `tp->sackhint.sack_bytes_rexmit = 0`

## Resolution

* xxx Statically check KASSERT on loop invariant or precondition

## Timeline

### Fri, Mar 5, 3:13 PM

https://reviews.freebsd.org/D29083
