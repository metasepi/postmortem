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

absvtype shared(a:vt@ype, l:addr) = (a@l | ptr l)

extern fun shared_make{a:vt@ype}{l:addr} (a@l | ptr l): shared(a, l)
extern fun shared_ref{a:vt@ype}{l:addr} (!shared(a, l)): shared(a, l)
extern fun shared_unref{a:vt@ype}{l:addr} (shared(a, l)): [c:int] (option_v(a@l, c <= 1) | ptr l, int c)

absview locked_v

extern fun shared_lock{a:vt@ype}{l:addr} (!shared(a, l)): (locked_v, a@l | ptr l)
extern fun shared_unlock{a:vt@ype}{l:addr} (locked_v, a@l | !shared(a, l), ptr l): void

local

extern praxi _unsafe_consume_atview{a:vt0p}{l:addr} (pf: a@l):<prf> void
datavtype shared_ (a:vt@ype, l:addr) = {c:int} SHARED of (a@l | spin1_vt, int c, ptr l)
assume shared = shared_

in

implement shared_make(pf | x) = let
    val spin = unsafe_spin_t2vt(spin_create_exn())
  in
    SHARED(pf | spin, 1, x)
  end

implement shared_ref{a}{l}(sh) = let
    val+@SHARED(pf | spin, count, _) = sh
    val spin = unsafe_spin_vt2t(spin)
    val (pfl | ()) = spin_lock(spin)
    val c0 = count
    val () = count := c0 + 1
    val () = spin_unlock(pfl | spin)
    prval () = fold@sh
  in
    $UN.castvwtp1{shared(a, l)}(sh)
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
    (* xxx TODO:
     * Should implement rwlock instead of spin lock? *)
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
(* xxx TODO:
 * Should support the structure `inpcb`? *)

extern fun ip6_pcbopts{l:addr}(!ip6_pktopts@l | ptr l): int
extern fun ip6_ctloutput{l:addr} (sh: !shared(ip6_pktopts, l)): int
extern fun ip6_thread{l:addr} (sh: shared(ip6_pktopts, l)): void

implement ip6_pcbopts(pf | x) = let
    val () = !x.ip6po_hlim := 1
  in
    0
  end

implement ip6_ctloutput(sh) = let
    val (pfl, pf | x) = shared_lock{ip6_pktopts}(sh)
    (* xxx TODO:
     * Can be locked twice. *)
    val error = ip6_pcbopts(pf | x)
    val () = shared_unlock(pfl, pf | sh, x)
  in
    error
  end

implement ip6_thread(sh) = let
    fun loop{l:addr}(sh: !shared(ip6_pktopts, l)): void = let
        val _ = ip6_ctloutput(sh)
      in
        loop(sh)
      end
    val () = loop(sh)
    val (_ | _, _) = shared_unref(sh)
  in
  end

implement main0() = let
    var opts: ip6_pktopts
    val () = opts.ip6po_hlim := 0
    val sh_inp0 = shared_make{ip6_pktopts}(view@opts | addr@opts)
    val sh_inp1 = shared_ref(sh_inp0)
    val sh_inp2 = shared_ref(sh_inp0)
    val sh_inp3 = shared_ref(sh_inp0)
    val _ = athread_create_cloptr_exn (llam () => ip6_thread(sh_inp1))
    val _ = athread_create_cloptr_exn (llam () => ip6_thread(sh_inp2))
    val _ = athread_create_cloptr_exn (llam () => ip6_thread(sh_inp3))
    val (pf_oopts | _, count) = shared_unref(sh_inp0)
    val () = assertloc(count <= 1)
    prval Some_v(pf_opts) = pf_oopts
    prval () = view@opts := (pf_opts: (ip6_pktopts?)@opts)
  in
    ignoret(usleep(1000u))
  end
