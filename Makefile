# No need for a Makefile, but 'make' is easier to type

all:
	fpc -Fu* pasbox.pas

clean:
	delp -r .

.PHONY: all clean
