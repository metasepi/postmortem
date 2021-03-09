# 236999 - vmx driver stops sending network packets and resets connections (TCP) but allows ICMP 

## Summary

https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=236999

## Root Causes

* Tried to download a 40MB file, the transfer would stop, the connection would reset
* Difficult

## Resolution

* None

## Timeline

### Dec 30 2019, 10:08 AM

https://reviews.freebsd.org/D22967
