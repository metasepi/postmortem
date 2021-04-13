#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

typedef unrhdr (lo,hi:int) = @{
  low = uint lo,
  high = uint hi
}

// free_unr() is a slim wrapper of free_unrl()
fun free_unrl
{l:addr}{lo,hi,it:int | it >= lo && it <= hi}
(pf: !unrhdr(lo,hi)@l | uh: ptr l, item: uint it)
: void = ()

implement main0 () = {
  var h = @{
    low = 1U,
    high = 3U
  }
  prval ph = view@h
  val () = free_unrl(ph | addr@h, 3U)
  prval () = view@h := ph
}
