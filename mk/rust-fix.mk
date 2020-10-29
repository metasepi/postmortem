all:
	rustc main.rs

clean:
	rm -f main

.PHONY: all clean
