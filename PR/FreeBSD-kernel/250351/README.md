# 250351 – [ZFS] [panic] panic: fpudna while in fpu_kern_enter(FPU_KERN_NOCTX)

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=250351

## Root Causes

* KASSERT occurs panic in `fpudna()`
* It's not fixed?
* Can statically check `__curthread()->td_md.md_pcb->pcb_flags`?
* Difficult

## Resolution

* None
