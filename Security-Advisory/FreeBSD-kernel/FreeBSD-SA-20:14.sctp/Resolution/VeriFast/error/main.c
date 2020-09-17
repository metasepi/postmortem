#include "stdlib.h"
#include "stdint.h"

#define EBUSY 16

typedef struct sctp_shared_key {
    uint32_t refcount;
    uint8_t deactivated;
} sctp_sharedkey_t;

void sctp_free_sharedkey(sctp_sharedkey_t *skey)
    //@ requires malloc_block_sctp_shared_key(skey) &*& skey->refcount |-> ?r &*& r <= 1 &*& skey->deactivated |-> _;
    //@ ensures true;
{
    free(skey);
}

int sctp_insert_sharedkey(sctp_sharedkey_t *skey)
    //@ requires malloc_block_sctp_shared_key(skey) &*& skey->refcount |-> _ &*& skey->deactivated |-> _;
    /*@
    ensures
        result == 0 ? // success
           true
        : // failure
           malloc_block_sctp_shared_key(skey) &*& skey->refcount |-> _ &*& skey->deactivated |-> _
        ;
    @*/
{
    if ((skey->deactivated) && (skey->refcount > 1)) {
        return EBUSY;
    }
    // Insert new_skey
    sctp_free_sharedkey(skey);
    return 0;
}

int main()
    //@ requires true;
    //@ ensures true;
{
    return 0;
}