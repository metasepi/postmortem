#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

absvtype lock(s:int)

extern praxi init_lock (): lock(0)
extern praxi fini_lock (lock(0)): void

fun do_lock {s:int | s == 0} (pf: !lock(s) >> lock(s+1) | ):void = {
  prval () = __change (pf) where {
    extern praxi __change (pf: !lock(s) >> lock(s+1)): void
  }
  // Do detail
}

fun do_unlock {s:int | s == 1} (pf: !lock(s) >> lock(s-1) | ):void = {
  prval () = __change (pf) where {
    extern praxi __change (pf: !lock(s) >> lock(s-1)): void
  }
  // Do detail
}

fun bridge_transmit {s:int | s == 0} (pflock: !lock(s) | ): int = let
    val () = do_lock (pflock | )
    val () = do_unlock (pflock | )
  in
    0
  end

fun bridge_delete_member {s:int | s == 1} (pflock: !lock(s) | ): void = let
    val () = do_unlock (pflock | )
    val r = bridge_transmit(pflock | )
    val () = do_lock (pflock | )
  in
    ()
  end

fun bridge_clone_destroy {s:int | s == 0} (pflock: !lock(s) | ): void = let
    val () = do_lock (pflock | )
    val () = bridge_delete_member(pflock | )
    val () = do_unlock (pflock | )
  in
    ()
  end

implement main0 () = {
}
