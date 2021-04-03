#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

absvtype lock(s:int)
vtypedef lock_0 = lock(0)
vtypedef lock_1 = lock(1)

extern praxi init_lock (): lock(0)
extern praxi fini_lock (lock_0): void

fun do_lock (pf: !lock_0 >> lock_1 | ):void = {
  prval () = __change (pf) where {
    extern praxi __change (pf: !lock_0 >> lock_1): void
  }
  // Do detail
}

fun do_unlock (pf: !lock_1 >> lock_0 | ):void = {
  prval () = __change (pf) where {
    extern praxi __change (pf: !lock_1 >> lock_0): void
  }
  // Do detail
}

fun bridge_transmit (pflock: !lock_0 | ): int = let
    val () = do_lock (pflock | )
    // Do detail
    val () = do_unlock (pflock | )
  in
    0
  end

fun bridge_delete_member (pflock: !lock_1 | ): void = let
    val () = do_unlock (pflock | )
    val r = bridge_transmit(pflock | )
    val () = do_lock (pflock | )
  in
    ()
  end

fun bridge_clone_destroy (pflock: !lock_0 | ): void = let
    val () = do_lock (pflock | )
    val () = bridge_delete_member(pflock | )
    val () = do_unlock (pflock | )
  in
    ()
  end

implement main0 () = {
}
