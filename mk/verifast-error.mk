all:
	@echo "Following should find error."
	$(SHELL) -c 'verifast -c main.c; test "$$?" != "0"'

clean:

.PHONY: all clean
