#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

typedef rtentry = @{
  member_a = int
}

typedef nhop_object = @{
  member_b = int
}

vtypedef rib_cmd_info = @{
  rc_rt = [l:addr] (rtentry @ l | ptr l)
}

fun rtsock_routemsg
{l1,l2:addr}
(pfrt: !rtentry@l1, pfnh: !nhop_object@l2 | cmd: int, rt: ptr l1, nh: ptr l2, fibnum: int):
int =
  cmd + !rt.member_a + !nh.member_b

implement main0 () = {
}
