all:
	patscc -D_GNU_SOURCE -DATS_MEMALLOC_LIBC main.dats -lpthread

clean:
	rm -f a.out main_dats.c

.PHONY: all clean
