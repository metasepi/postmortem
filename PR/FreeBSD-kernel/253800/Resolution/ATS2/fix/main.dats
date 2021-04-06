#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

#define RTM_DELETE 0x2
#define ENOTSUP 45

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

fun rib_del_route
{l:addr}
(pf: !rib_cmd_info@l | rc: ptr l):
int =
  0

fun rib_action
{l:addr}
(pf: !rib_cmd_info@l | action: int, rc: ptr l):
int =
  case+ action of
    | RTM_DELETE => rib_del_route(pf | rc)
    | _ => ENOTSUP

implement main0 () = {
}
