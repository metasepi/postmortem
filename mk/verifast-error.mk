all:
	@echo "Following should find error."
	$(SHELL) -c 'verifast main.c; test "$$?" != "0"'

clean:

.PHONY: all clean
