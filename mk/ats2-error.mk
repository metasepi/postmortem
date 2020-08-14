all:
	@echo "Following should find error."
	$(SHELL) -c 'patscc main.dats; test "$$?" != "0"'

clean:
	rm -f a.out main_dats.c

.PHONY: all clean
