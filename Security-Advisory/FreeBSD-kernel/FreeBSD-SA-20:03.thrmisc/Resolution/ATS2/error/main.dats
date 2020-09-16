#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

typedef elf_thrmisc_t = @{ pr_tname = char, _pad = uint }
(* xxx TODO:
 * Should define `pr_tname` as array of char. *)

fun bzero {a:vt@ype}{l:addr} (pf: !a? @ l >> a @ l | p: ptr l): void =
  undefined()

fun sbuf_bcat {a:vt@ype}{l:addr} (pf: !a @ l | p: ptr l): void =
  undefined()

fun note_thrmisc(): void = {
  var thrmisc: elf_thrmisc_t
  prval pf_thrmisc_pad = view@thrmisc._pad
  val addr_thrmisc_pad = addr@thrmisc._pad
  val () = bzero(pf_thrmisc_pad | addr_thrmisc_pad)
  prval () = view@thrmisc._pad := pf_thrmisc_pad

  prval pf_thrmisc = view@thrmisc
  val addr_thrmisc = addr@thrmisc
  val () = sbuf_bcat(pf_thrmisc | addr_thrmisc)
  (* xxx TODO:
   * Why does above call succeed? `thrmisc.pr_tname` is not initialized. *)
  prval () = view@thrmisc:= pf_thrmisc
}

implement main0 () = {
}
