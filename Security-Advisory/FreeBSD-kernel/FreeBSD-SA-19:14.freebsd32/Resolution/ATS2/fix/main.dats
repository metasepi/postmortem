#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
staload UN = "prelude/SATS/unsafe.sats"

typedef pci_conf32 = @{ pc_hdr = uchar, pc_class = uchar, pd_name = char }
(* xxx TODO:
 * Should define `pd_name` as array of char. *)

fun memset {a:vt@ype}{l:addr} (pf: !a? @ l >> a @ l | p: ptr l): void =
  undefined()

fun copyout {a:vt@ype}{l:addr} (pf: !a @ l | p: ptr l): void =
  undefined()

fun copyout_pc32 {l:addr} (pf: !pci_conf32 @ l | p: ptr l): void =
  copyout(pf | p)
  (* xxx TODO:
   * Can we create a polymorphic `copyout_pc32` function to avoid returning uninitialized value? *)

fun freebsd32_ioctl_pciocgetconf(): int = 0 where {
  val nmatch_to_convert = 10
  fun loop {l:addr} (pf_pc32: !pci_conf32 @ l | addr_pc32: ptr l, i: int): void =
    if i >= nmatch_to_convert then ()
    else {
      val () = !addr_pc32.pc_hdr := $UN.cast 1
      val () = !addr_pc32.pc_class := $UN.cast 2
      val () = copyout_pc32(pf_pc32 | addr_pc32)
    }
  var pc32: pci_conf32
  prval pf_pc32 = view@pc32
  val addr_pc32 = addr@pc32
  val () = memset(pf_pc32 | addr_pc32)
  val () = loop(pf_pc32 | addr_pc32, 0)
  prval () = view@pc32 := pf_pc32
}

implement main0 () = {
}
