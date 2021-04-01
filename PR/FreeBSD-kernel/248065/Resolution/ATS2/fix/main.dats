#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

abst0ype linux_flags = int
abst0ype bsd_flags = int

typedef linux_send_args = @{
  flags = linux_flags
}
typedef sendto_args = @{
  flags = bsd_flags
}

fun linux_to_bsd_msg_flags(flags: linux_flags): bsd_flags =
  undefined()

fun linux_send {l:addr} (pf: !linux_send_args@l | args: ptr l): int = let
    var bsd_args: sendto_args
    val () = bsd_args.flags := linux_to_bsd_msg_flags(!args.flags)
  in
    0
  end

implement main0 () = {
}
