#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* struct file *)
typedef struct_file = @{ f_data = ptr }

extern fun fdrop {l:addr} (pf_fp: struct_file@l | fp: ptr l): void = "mac#free"

fun copyin (): int =
  0

(* xxx TODO:
 * `getmq_read` may return NULL and error code.
 * But caller can dereference follong `ptr l`. *)
fun getmq_read (): [l:addr] (struct_file@l | ptr l, int) =
  undefined()

fun sys_kmq_timedreceive (): int = let
    val (pf_fp | fp, error) = getmq_read()
  in
    (* xxx TODO:
     * `fdrop` should not produce atpview `pf_fp` on error case. *)
    if error != 0 then (fdrop (pf_fp | fp); error)
    else let
        val error = copyin ()
      in
        if error != 0 then error
        else
          (* Do something *)
          (fdrop (pf_fp | fp); error)
      end
  end

implement main0 () = {
}
