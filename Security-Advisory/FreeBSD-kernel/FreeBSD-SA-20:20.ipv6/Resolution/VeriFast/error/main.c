#include "stdlib.h"
#include "threading.h"

struct ip6_pktopts {
    int ip6po_hlim;
};

struct inpcb {
    struct ip6_pktopts *in6p_outputopts;
    struct mutex *mutex;
    /* xxx TODO:
     * Should implement rwlock instead of mutex? */
};

//@ predicate_ctor inpcb(struct inpcb *inpcb)() = inpcb->in6p_outputopts |-> ?p &*& p->ip6po_hlim |-> _;

/*@
predicate_family_instance thread_run_data(ip6_thread)(struct inpcb *inpcb) =
    [1/100]inpcb->mutex |-> ?mutex &*& [1/100]mutex(mutex, inpcb(inpcb));
@*/

int ip6_pcbopts(struct ip6_pktopts **pktopt)
    //@ requires pointer(pktopt, ?p) &*& ip6_pktopts_ip6po_hlim(p, _);
    //@ ensures pointer(pktopt, ?p2) &*& ip6_pktopts_ip6po_hlim(p2, 1);
{
    (*pktopt)->ip6po_hlim = 1;
    return 0;
}

int ip6_ctloutput(struct inpcb *inp)
    //@ requires thread_run_data(ip6_thread)(inp);
    //@ ensures thread_run_data(ip6_thread)(inp);
{
    int error;
    //@ open thread_run_data(ip6_thread)(inp);
    struct mutex *m = inp->mutex;
    error = ip6_pcbopts(&inp->in6p_outputopts);
    //@ close thread_run_data(ip6_thread)(inp);
    return error;
}

void ip6_thread(struct inpcb *inp) //@ : thread_run
    //@ requires thread_run_data(ip6_thread)(inp);
    //@ ensures false;
{
    while (true)
        //@ invariant thread_run_data(ip6_thread)(inp);
    {
        ip6_ctloutput(inp);
    }
}

void ip6_thread_async(struct inpcb *inp)
    //@ requires [1/100]inp->mutex |-> ?mutex &*& [1/100]mutex(mutex, inpcb(inp));
    //@ ensures true;
{
    //@ close thread_run_data(ip6_thread)(inp);
    thread_start(ip6_thread, inp);
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

    ip6_thread_async(inp);
    ip6_thread_async(inp);
    ip6_thread_async(inp);

    while (true)
        //@ invariant true;
    {}

    return 0;
}