#include "stdlib.h"
#include "threading.h"

struct ip6_pktopts {
    int ip6po_hlim;
};

struct inpcb {
    struct ip6_pktopts *in6p_outputopts;
    struct mutex *mutex; // Instead of `struct rwlock`
};

//@ predicate_ctor inpcb(struct inpcb *inpcb)() = inpcb->in6p_outputopts |-> ?p &*& p->ip6po_hlim |-> _;

int ip6_pcbopts(struct ip6_pktopts **pktopt)
    //@ requires pointer(pktopt, ?p) &*& ip6_pktopts_ip6po_hlim(p, _);
    //@ ensures pointer(pktopt, ?p2) &*& ip6_pktopts_ip6po_hlim(p2, 1);
{
    (*pktopt)->ip6po_hlim = 1;
    return 0;
}

int ip6_ctloutput(struct inpcb *inp)
    //@ requires [1/10]inp->mutex |-> ?mutex &*& [1/10]mutex(mutex, inpcb(inp));
    //@ ensures [1/10]inp->mutex |-> ?mutex2 &*& [1/10]mutex(mutex2, inpcb(inp));
{
    int error;
    struct mutex *m = inp->mutex;
    mutex_acquire(m);
    //@ open inpcb(inp)();
    error = ip6_pcbopts(&inp->in6p_outputopts);
    //@ close inpcb(inp)();
    mutex_release(m);
    return error;
}

int main()
    //@ requires true;
    //@ ensures false;
{
    struct ip6_pktopts *opt = malloc(sizeof(struct ip6_pktopts));
    if (opt == 0) abort();
    struct inpcb *inp = malloc(sizeof(struct inpcb));
    if (inp == 0) abort();
    inp->in6p_outputopts = opt;
    //@ close inpcb(inp)();
    //@ close create_mutex_ghost_arg(inpcb(inp));
    struct mutex *mutex = create_mutex();
    inp->mutex = mutex;

    while (true)
        //@ invariant true;
    {}

    return 0;
}