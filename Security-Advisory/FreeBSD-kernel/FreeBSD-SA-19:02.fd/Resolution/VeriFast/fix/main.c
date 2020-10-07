#include "stdlib.h"

struct file {
    void *f_data;
};

void fdclose(struct file *fp, int fd)
    //@ requires true;
    //@ ensures true;
{
}

void fdrop(struct file *fp)
    //@ requires file_f_data(fp, _) &*& malloc_block_file(fp);
    //@ ensures true;
{
    free(fp);
}

int fget(struct file **fpp)
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

int m_dispose_extcontrolm()
    //@ requires true;
    //@ ensures true;
{
    int fd = 1;
    int nfd = 10;
    int error;
    while (nfd > 0)
        //@ invariant emp;
    {
        struct file *fp;
        error = fget(&fp);
        if (error == 0) {
            fdclose(fp, fd);
            fdrop(fp);
        }
        nfd--;
    }
    return 0;
}

int main()
    //@ requires true;
    //@ ensures true;
{
    return 0;
}
