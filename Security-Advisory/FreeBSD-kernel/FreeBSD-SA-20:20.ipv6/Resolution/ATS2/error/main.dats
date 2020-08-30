%{^
#include <pthread.h>
%}

#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
staload UN = $UNSAFE
staload "libats/libc/SATS/unistd.sats"
staload "libats/SATS/athread.sats"
staload _ = "libats/DATS/athread.dats"
staload _ = "libats/DATS/athread_posix.dats"

absvtype shared(a:vt@ype) = [l:addr] (a@l | ptr l)

extern fun shared_make{a:vt@ype}{l:addr} (a@l | ptr l): shared(a)
extern fun shared_ref{a:vt@ype} (!shared(a)): shared(a)
extern fun shared_unref{a:vt@ype} (shared(a)): [l:addr][c:int] (option_v(a@l, c <= 1) | ptr l, int c)

absview locked_v

extern fun shared_lock{a:vt@ype} (!shared(a)): [l:addr] (locked_v, a@l | ptr l)
extern fun shared_unlock{a:vt@ype}{l:addr} (locked_v, a@l | !shared(a), ptr l): void

local

extern praxi _unsafe_consume_atview{a:vt0p}{l:addr} (pf: a@l):<prf> void
datavtype shared_ (a:vt@ype) = {l:addr}{c:int} SHARED of (a@l | spin1_vt, int c, ptr l)
assume shared = shared_

in

implement shared_make(pf | x) = let
    val spin = unsafe_spin_t2vt(spin_create_exn())
  in
    SHARED(pf | spin, 1, x)
  end

implement shared_ref{a}(sh) = let
    val+@SHARED(pf | spin, count, _) = sh
    val spin = unsafe_spin_vt2t(spin)
    val (pfl | ()) = spin_lock(spin)
    val c0 = count
    val () = count := c0 + 1
    val () = spin_unlock(pfl | spin)
    prval () = fold@sh
  in
    $UN.castvwtp1{shared(a)}(sh)
  end

implement shared_unref{a}(sh) = let
    val+@SHARED(pf | spin, count, x) = sh
    val spin = unsafe_spin_vt2t(spin)
    val (pfl | ()) = spin_lock(spin)
    val c0 = count
    val () = count := c0 - 1
    val x0 = x
    val () = spin_unlock(pfl | spin)
    prval () = fold@sh
  in
    if c0 <= 1
    then let
        val+~SHARED(pf | spin, _, x) = sh
        val () = spin_vt_destroy(spin)
      in
        (Some_v(pf) | x, c0)
      end
    else let prval () = $UN.cast2void(sh) in (None_v() | x0, c0) end
  end

implement shared_lock{a}(sh) = let
    val+@SHARED(pf | spin, _, x) = sh
    val spin = unsafe_spin_vt2t(spin)
    val (pfl | ()) = spin_lock(spin)
    val x0 = x
    prval pf0 = $UN.castview1(pf)
    prval () = fold@sh
  in
    ($UN.castview0(pfl), pf0 | x0)
  end

implement shared_unlock{a}(pfl, pf0 | sh, x0) = let
    val+@SHARED(pf | spin, _, _) = sh
    val spin = unsafe_spin_vt2t(spin)
    prval () = _unsafe_consume_atview(pf0)
    val () = spin_unlock($UN.castview0(pfl) | spin)
    prval () = fold@sh
  in
  end

end // end of [local]

typedef ip6_pktopts = @{ ip6po_hlim = int }
vtypedef inpcb = @{
  in6p_outputopts = ptr,
  sh = shared(ip6_pktopts)
}

implement main0 () = let
    var opts: ip6_pktopts with opts_pf
    var inp: inpcb
    val () = inp.in6p_outputopts := addr@opts
    val () = inp.sh := shared_make(opts_pf | addr@opts)
    val (pf_oopts | x, count) = shared_unref(inp.sh)
    val () = assertloc(count <= 1)
    prval Some_v(pf_opts) = pf_oopts
    val () = assertloc(x = addr@opts)
    prval () = opts_pf := pf_opts
  in
    ignoret(usleep(1000u))
  end
