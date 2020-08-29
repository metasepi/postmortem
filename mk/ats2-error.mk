all:
	@echo "Following should find error."
	$(SHELL) -c 'patscc -D_GNU_SOURCE -DATS_MEMALLOC_LIBC main.dats -lpthread; test "$$?" != "0"'

clean:
	rm -f a.out main_dats.c

.PHONY: all clean
