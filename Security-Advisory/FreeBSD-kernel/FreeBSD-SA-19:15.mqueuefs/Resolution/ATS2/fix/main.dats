#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* struct file *)
typedef struct_file = @{ f_data = ptr }

extern fun fdrop {l:addr} (pf_fp: struct_file@l | fp: ptr l): void = "mac#free"

(* xxx TODO:
 * `getmq_read` may return NULL and error code.
 * But caller can dereference follong `ptr l`. *)
fun getmq_read (): [l:addr] (struct_file@l | ptr l, int) =
  undefined()

fun sys_kmq_timedreceive (): int = let
  val (pf_fp | fp, error) = getmq_read()
  val () = fdrop (pf_fp | fp)
  in
    error
  end

implement main0 () = {
}
