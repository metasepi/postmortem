#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* struct file *)
typedef struct_file = @{ f_data = ptr }

extern fun fdrop {l:addr} (pf_fp: struct_file@l | fp: ptr l): void = "mac#free"

fun fdclose {l:addr} (pf_fp: !struct_file@l | fp: ptr l): void =
  undefined()

fun fget (): [l:addr][i:int] (option_v(struct_file@l, i == 0) | ptr l, int i) =
  undefined()

fun sys_kmq_timedreceive (): int = let
    fun loop {n:int | n >= 0} (nfd: int n): void =
      if nfd <= 0 then ()
      else let
          val (pf_fp | fp, error) = fget()
          val () = if error = 0 then {
              prval Some_v(pf_fp2) = pf_fp
              val () = fdclose(pf_fp2 | fp)
            }
            else {
              prval None_v() = pf_fp
            }
        in
          loop(nfd - 1)
        end
    val fd = 1
    val nfd = 10
  in
    loop 10; 0
  end

implement main0 () = {
}
