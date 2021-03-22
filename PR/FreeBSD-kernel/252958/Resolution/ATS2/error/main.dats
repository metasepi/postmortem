#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"

fun{tk:tk} g0g1uint_div {i:int | i > 0} (x: g0uint (tk), y: g1uint (tk, i)): g0uint (tk) =
  g0uint_div(x, $UN.cast y)

overload / with g0g1uint_div of 1

typedef sackhint (s:int) = @{recover_fs = uint s, prr_delivered = uint}

fun tcp_prr_partialack {l:addr}{s:int} (pf: !sackhint(s)@l | v: ptr l): uint = let
    val snd_cnt = !v.prr_delivered / !v.recover_fs
  in
    snd_cnt
  end

implement main0 () = {
}
