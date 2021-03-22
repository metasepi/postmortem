#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"

fun{tk:tk} g1g0uint_max {i:int} (x: g1uint (tk, i), y: g0uint (tk)): [r:int | r >= i] g1uint (tk, r) =
  undefined()

overload max with g1g0uint_max of 1

fun{tk:tk} g0g1uint_div {i:int | i > 0} (x: g0uint (tk), y: g1uint (tk, i)): g0uint (tk) =
  g0uint_div(x, $UN.cast y)

overload / with g0g1uint_div of 1

typedef sackhint (s:int) = @{
    recover_fs = uint s
  , prr_delivered = uint
  , snd_nxt = uint
  , snd_una = uint
}

fun tcp_prr_partialack {l:addr}{s:int} (pf: !sackhint(s)@l >> sackhint(t)@l | v: ptr l): #[t:int] uint = let
    val () = !v.recover_fs := max(1U, !v.snd_nxt - !v.snd_una)
    val snd_cnt = !v.prr_delivered / !v.recover_fs
  in
    snd_cnt
  end

implement main0 () = {
}
