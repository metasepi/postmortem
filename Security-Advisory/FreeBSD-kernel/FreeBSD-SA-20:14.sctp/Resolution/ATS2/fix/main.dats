#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

#define EBUSY 16

typedef sctp_shared_key (r:int) = @{refcount = uint r, deactivated = uint}

fun sctp_alloc_sharedkey (): [l:addr][r:int] (sctp_shared_key(r) @ l | ptr l) =
  undefined ()
extern fun sctp_force_free_sharedkey {l:addr}{r:int} (pf_skey: sctp_shared_key(r) @ l | skey: ptr l): void = "mac#free"
extern fun sctp_free_sharedkey {l:addr}{r:int | r <= 1} (pf_skey: sctp_shared_key(r) @ l | skey: ptr l): void = "mac#free"

fun sctp_insert_sharedkey {l:addr}{r:int} (pf_skey: !sctp_shared_key(r) @ l >> option_v (sctp_shared_key(r) @ l, n != 0) | skey: ptr l): #[n:int] int n =
  if (!skey.deactivated != 0) + (!skey.refcount > 1)
  then let
      prval () = pf_skey := Some_v pf_skey
    in
      EBUSY
    end
  else let
      // Insert new_skey
      val () = sctp_free_sharedkey(pf_skey | skey)
      prval () = pf_skey := None_v ()
    in
      0
    end

implement main0 () = let
    val (pf_skey | skey) = sctp_alloc_sharedkey()
    val ret = sctp_insert_sharedkey(pf_skey | skey)
  in
    if ret = 0 then let
        prval None_v () = pf_skey
      in
        ()
      end
    else let
        prval Some_v (pf) = pf_skey
      in
        sctp_force_free_sharedkey(pf | skey)
      end
  end
