PasBox
======

PasBox is a multi-call binary similar to BusyBox implemented in Free
Pascal as a demonstration project to show that things could be simpler.
It's not meant to be a complete implementation, just an example.

* No Makefile, to compile just do 'fpc -Fu* pasbox'. To clean you may use the
  utility 'delp -r .'.
* Free Pascal Compiler is faster and easier. To cross compile just pass the
  -P and -T options.
* No libc dependency, just a single small static binary.
