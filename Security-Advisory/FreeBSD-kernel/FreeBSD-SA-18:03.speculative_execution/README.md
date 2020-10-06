# FreeBSD-SA-18:03.speculative_execution Postmortem

## Summary

A number of issues relating to speculative execution were found last year and publicly announced January 3rd.  Two of these, known as Meltdown and Spectre V2, are addressed here.

### CVE-2017-5754 (Meltdown)

This issue relies on an affected CPU speculatively executing instructions beyond a faulting instruction.  When this happens, changes to architectural state are not committed, but observable changes may be left in micro-architectural state (for example, cache).  This may be used to infer privileged data.

### CVE-2017-5715 (Spectre V2)

Spectre V2 uses branch target injection to speculatively execute kernel code at an address under the control of an attacker.

## Root Causes

xxx

## Resolution

xxx

## File

* sys/amd64/amd64/apic_vector.S
* sys/amd64/amd64/atpic_vector.S
* sys/amd64/amd64/cpu_switch.S
* sys/amd64/amd64/db_trace.c
* sys/amd64/amd64/exception.S
* sys/amd64/amd64/genassym.c
* sys/amd64/amd64/initcpu.c
* sys/amd64/amd64/machdep.c
* sys/amd64/amd64/mp_machdep.c
* sys/amd64/amd64/pmap.c
* sys/amd64/amd64/support.S
* sys/amd64/amd64/sys_machdep.c
* sys/amd64/amd64/trap.c
* sys/amd64/amd64/vm_machdep.c
* sys/amd64/ia32/ia32_exception.S
* sys/amd64/ia32/ia32_syscall.c
* sys/amd64/include/asmacros.h
* sys/amd64/include/frame.h
* sys/amd64/include/intr_machdep.h
* sys/amd64/include/md_var.h
* sys/amd64/include/pcb.h
* sys/amd64/include/pcpu.h
* sys/amd64/include/pmap.h
* sys/amd64/include/smp.h
* sys/amd64/vmm/intel/vmx.c
* sys/amd64/vmm/vmm.c
* sys/conf/Makefile.amd64
* sys/dev/cpuctl/cpuctl.c
* sys/dev/hyperv/vmbus/amd64/vmbus_vector.S
* sys/dev/hyperv/vmbus/i386/vmbus_vector.S
* sys/dev/hyperv/vmbus/vmbus.c
* sys/i386/i386/apic_vector.s
* sys/i386/i386/atpic_vector.s
* sys/i386/i386/exception.s
* sys/i386/i386/machdep.c
* sys/i386/i386/pmap.c
* sys/i386/i386/support.s
* sys/i386/i386/vm_machdep.c
* sys/sys/cpuctl.h
* sys/x86/include/apicvar.h
* sys/x86/include/specialreg.h
* sys/x86/include/x86_smp.h
* sys/x86/include/x86_var.h
* sys/x86/isa/atpic.c
* sys/x86/x86/cpu_machdep.c
* sys/x86/x86/identcpu.c
* sys/x86/x86/local_apic.c
* sys/x86/x86/mp_x86.c
* sys/x86/xen/pv.c

## Timeline

xxx

## Supporting information

* Security Advisory: https://www.freebsd.org/security/advisories/FreeBSD-SA-18:03.speculative_execution.asc
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2017-5715
* CVE: https://nvd.nist.gov/vuln/detail/CVE-2017-5754
