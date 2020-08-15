all:
	patscc -DATS_MEMALLOC_LIBC main.dats

clean:
	rm -f a.out main_dats.c

.PHONY: all clean
