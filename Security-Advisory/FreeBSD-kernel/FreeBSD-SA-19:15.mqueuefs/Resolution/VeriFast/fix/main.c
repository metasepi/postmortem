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

void fdrop(struct file *fp)
    //@ requires file_f_data(fp, _) &*& malloc_block_file(fp);
    //@ ensures true;
{
    free(fp);
}

int getmq_read(struct file **fpp)
    //@ requires pointer(fpp, _);
    /*@
    ensures
        result == 0 ? // success
           pointer(fpp, ?p) &*& file_f_data(p, _) &*& malloc_block_file(p)
        : // failure
           pointer(fpp, _)
        ;
    @*/
{
    *fpp = malloc(sizeof(struct file));
    if (*fpp == NULL) {
        return 1;
    }
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
        goto out;
    }
    // Do something
out:
    fdrop(fp);
    return 0;
}

int main()
    //@ requires true;
    //@ ensures true;
{
    return 0;
}
