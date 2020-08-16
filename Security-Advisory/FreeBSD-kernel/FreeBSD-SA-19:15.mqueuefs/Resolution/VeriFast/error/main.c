#include "stdlib.h"

struct file {
    void *f_data;
};

int copyin()
    //@ requires true;
    //@ ensures true;
{
    return 0;
}

int getmq_read(struct file **fpp)
    //@ requires pointer(fpp, _);
    /*@
    ensures
        switch (result) {
           case ints_nil: return pointer(fpp, ?p) &*& file_f_data(p, _);
           case ints_cons(value, values0): return true;
        };
    @*/
{
    struct file *p = malloc(sizeof(struct file));
    if (p == NULL) {
        return 1;
    }
    *fpp = p;
    return 0;
}

int sys_kmq_timedreceive()
    //@ requires true;
    //@ ensures true;
{
    struct file *fp;
    int error;
    error = getmq_read(&fp);
    if (error) {
        return error;
    }
    error = copyin();
    if (error) {
        return error;
    }
    return 0;
}

int main()
    //@ requires true;
    //@ ensures true;
{
    return 0;
}