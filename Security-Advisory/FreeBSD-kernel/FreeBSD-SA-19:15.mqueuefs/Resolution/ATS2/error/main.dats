#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* struct file *)
typedef struct_file = @{ f_data = ptr }

(* `getmq_read` may return NULL and error code. It should be catch by caller. *)
fun getmq_read (): [l:addr] (struct_file@l | int, ptr l) =
  undefined()

fun sys_kmq_timedreceive (): int =
  undefined()

implement main0 () = {
}
