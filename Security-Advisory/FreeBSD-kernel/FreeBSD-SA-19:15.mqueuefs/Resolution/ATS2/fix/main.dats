#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* struct file *)
typedef struct_file = @{ f_data = ptr }

extern fun fdrop {l:addr} (pf_fp: struct_file@l | fp: ptr l): void = "mac#free"

fun copyin (): int =
  0

fun getmq_read (): [l:addr][i:int] (option_v(struct_file@l, i == 0) | ptr l, int i) =
  undefined()

fun sys_kmq_timedreceive (): int = let
    val (pf_fp | fp, error) = getmq_read()
  in
    if error != 0 then let prval None_v() = pf_fp in error end
    else let
        prval Some_v(pf_fp2) = pf_fp
        val error = copyin ()
      in
        if error != 0 then (fdrop (pf_fp2 | fp); error)
        else
          (* Do something *)
          (fdrop (pf_fp2 | fp); error)
      end
  end

implement main0 () = {
}
