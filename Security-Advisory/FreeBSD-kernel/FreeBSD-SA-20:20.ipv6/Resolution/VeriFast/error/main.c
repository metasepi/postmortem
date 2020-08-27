#include "stdlib.h"
#include "threading.h"

struct ip6_pktopts {
    int ip6po_hlim;
};

struct inpcb {
    struct ip6_pktopts *in6p_outputopts;
    struct mutex *mutex; // Instead of `struct rwlock`
};

int ip6_pcbopts(struct ip6_pktopts **pktopt)
    //@ requires pointer(pktopt, ?p) &*& ip6_pktopts_ip6po_hlim(p, _);
    //@ ensures pointer(pktopt, ?p2) &*& ip6_pktopts_ip6po_hlim(p2, 1);
{
    (*pktopt)->ip6po_hlim = 1;
    return 0;
}

int
ip6_ctloutput(struct inpcb *inp)
    //@ requires inpcb_in6p_outputopts(inp, ?p) &*& ip6_pktopts_ip6po_hlim(p, _);
    //@ ensures inpcb_in6p_outputopts(inp, ?p2) &*& ip6_pktopts_ip6po_hlim(p2, _);
{
    int error;
    error = ip6_pcbopts(&inp->in6p_outputopts);
    return error;
}

int main()
    //@ requires true;
    //@ ensures true;
{
    return 0;
}