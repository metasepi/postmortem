#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

#define EBUSY 16

typedef sctp_shared_key = @{ refcount = uint, deactivated = uint }

extern fun sctp_free_sharedkey {l:addr} (pf_skey: sctp_shared_key @ l | skey: ptr l): void = "mac#free"

fun sctp_insert_sharedkey {l:addr} (pf_skey: sctp_shared_key @ l | skey: ptr l): [n:int] (option_v (sctp_shared_key @ l, n != 0) | int n) =
  if !skey.deactivated != 0 || !skey.refcount > 1 then (Some_v pf_skey | EBUSY)
  else let
      // Insert new_skey
      val () = sctp_free_sharedkey(pf_skey | skey)
    in
      (None_v () | 0)
    end

implement main0 () = {
}
