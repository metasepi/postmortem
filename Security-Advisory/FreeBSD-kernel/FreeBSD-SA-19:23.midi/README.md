# FreeBSD-SA-19:23.midi Postmortem

## Summary

The kernel driver for /dev/midistat implements a handler for read(2). This handler is not thread-safe, and a multi-threaded program can exploit races in the handler to cause it to copy out kernel memory outside the boundaries of midistat's data buffer.

## Root Causes

* Use `sx` lock instead of `mtx` to avoid race on threads
* Don't use `static int midistat_bufptr` which causes race

## Resolution

xxx

## File

* sys/dev/sound/midi/midi.c

## Timeline

### Tue Aug 20 17:52:12 2019 +0000

https://github.com/freebsd/freebsd/commit/578ed341896611f6b419255564139e371a3344f2

Fixed by markj.

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-19:23.midi.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2019-5612
