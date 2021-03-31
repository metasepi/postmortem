#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"

#define MAXPAGESIZES 3

fun{tk:tk} g0g1ulint_div {i:int | i > 0} (x: ulint, y: ulint i): ulint =
  g0uint_div_ulint(x, $UN.cast y)

overload / with g0g1ulint_div of 1

fun arc4rand(): ulint =
  undefined()

fun roundup {i:int | i > 0} (x: ulint, y: ulint i): ulint =
  ((x + (y - 1UL)) / y) * y

fun concat_rnd_base {i:int | i > 0}  (minv: ulint, maxv: ulint, align: ulint i): ulint = let
    val rbase = arc4rand()
  in
    roundup(minv, align) + rbase % (maxv - minv)
  end

fun concat_exec_imgact {i:int} (pagesizes: &(@[ulint i][MAXPAGESIZES])): ulint = let
    var minv: ulint = 0UL
    var maxv: ulint = 0UL
    val psize = (if (MAXPAGESIZES > 1) * (pagesizes[1] > 0UL)
                   then pagesizes[1]
                   else if pagesizes[0] > 0UL
                     then pagesizes[0]
                     else 1UL): [i:int | i > 0] ulint i
  in
    concat_rnd_base(minv, maxv, psize)
  end

implement main0 () = {
}
