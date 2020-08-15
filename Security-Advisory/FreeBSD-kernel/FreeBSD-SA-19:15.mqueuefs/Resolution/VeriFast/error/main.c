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
{
    *fpp = malloc(sizeof(struct file));
    if (NULL == *fpp) {
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