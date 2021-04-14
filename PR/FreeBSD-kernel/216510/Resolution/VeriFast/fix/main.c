#include "stdlib.h"
#include "threading.h"

struct bridge_softc {
    struct mutex *mutex;
};

//@ predicate_ctor bridge_softc(struct bridge_softc *bridge_softc)() = true;

/*@
predicate_family_instance thread_run_data(bridge_thread)(struct bridge_softc *bridge_softc) =
    [1/100]bridge_softc->mutex |-> ?mutex &*& [1/100]mutex(mutex, bridge_softc(bridge_softc));
@*/

int bridge_delete_member(struct bridge_softc *bridge_softc)
    //@ requires [1/100]bridge_softc->mutex |-> ?mutex &*& mutex_held(mutex, ?p, currentThread, ?f) &*& p();
    //@ ensures [1/100]bridge_softc->mutex |-> mutex &*& mutex_held(mutex, p, currentThread, f) &*& p();
{
    struct mutex *m = bridge_softc->mutex;
    mutex_release(m);
    mutex_acquire(m);
    return 0;
}

void bridge_clone_destroy(struct bridge_softc *bridge_softc)
    //@ requires thread_run_data(bridge_thread)(bridge_softc);
    //@ ensures thread_run_data(bridge_thread)(bridge_softc);
{
    //@ open thread_run_data(bridge_thread)(bridge_softc);
    struct mutex *m = bridge_softc->mutex;
    mutex_acquire(m);
    bridge_delete_member(bridge_softc);
    mutex_release(m);
    //@ close thread_run_data(bridge_thread)(bridge_softc);
}

void bridge_thread(struct bridge_softc *bridge_softc) //@ : thread_run
    //@ requires thread_run_data(bridge_thread)(bridge_softc);
    //@ ensures false;
{
    while (true)
        //@ invariant thread_run_data(bridge_thread)(bridge_softc);
    {
        bridge_clone_destroy(bridge_softc);
    }
}

int main()
    //@ requires true;
    //@ ensures true;
{
    return 0;
}