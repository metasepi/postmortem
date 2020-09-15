#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

(* struct file *)
typedef struct_file = @{ f_data = ptr }

extern fun fdrop {l:addr} (pf_fp: struct_file@l | fp: ptr l): void = "mac#free"

fun copyin (): int =
  0

fun getmq_write (): [l:addr][i:int] (option_v(struct_file@l, i == 0) | ptr l, int i) =
  undefined()

fun freebsd32_kmq_timedsend {l:addr} (pf_uap_abs_timeout: !int@l | uap_abs_timeout: ptr l): int = let
    var _abs_timeout: int
    fun get_timeout {l:addr} (pf_uap_abs_timeout: !int@l | uap_abs_timeout: ptr l): (int, ptr) =
      if uap_abs_timeout != the_null_ptr
      then let
          val error = copyin()
        in
          if error != 0 then (error, the_null_ptr)
          else (0, addr@_abs_timeout)
        end
      else (0, the_null_ptr)
    val (pf_fp | fp, error) = getmq_write()
  in
    if error != 0 then let prval None_v() = pf_fp in error end
    else let
        prval Some_v(pf_fp2) = pf_fp
        val (error, abs_timeout) = get_timeout(pf_uap_abs_timeout | uap_abs_timeout)
      in
        (* Do something *)
        (fdrop (pf_fp2 | fp); error)
      end
  end

implement main0 () = {
}
