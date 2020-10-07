#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

typedef kld_file_stat = @{ version = int, name = char, refs = int, id = int, address = ptr, size = size_t, pathname = char }
(* xxx TODO:
 * Should define `name` and `pathname` as array of char. *)

fun bzero {a:vt@ype}{l:addr} (pf: !a? @ l >> a @ l | p: ptr l): void =
  undefined()

fun copyout {a:vt@ype}{l:addr} (pf: !a @ l | p: ptr l): int =
  undefined()

fun copy_stat {l:addr} (pf: !kld_file_stat @ l | p: ptr l): int =
  copyout(pf | p)
  (* xxx TODO:
   * Can we create a polymorphic `copy_stat` function to avoid returning uninitialized value? *)

fun kern_kldstat {l:addr} (pf: !kld_file_stat @ l | p: ptr l): int = 0 where {
  val () = !p.name := 'A'
  val () = !p.refs := 1
  val () = !p.id := 2
  val () = !p.address := p
  val () = !p.size := sizeof<kld_file_stat>
  val () = !p.pathname := 'P'
}

fun sys_kldstat (): int = 0 where {
  var stat: kld_file_stat
  prval pf_stat = view@stat
  val addr_stat = addr@stat
  val _ = kern_kldstat(pf_stat | addr_stat)
  prval () = view@stat := pf_stat

  prval pf_stat = view@stat
  val addr_stat = addr@stat
  val _ = copy_stat(pf_stat | addr_stat);
  prval () = view@stat := pf_stat
}

implement main0 () = {
}
