ALL_EXE = heat_test
all: $(ALL_EXE) 

CC=gcc
CFLAGS=-I. -I../include  -I../API -I../hw -Wall

DEPS = Makefile ../hw/proto2_hw.h ../hw/xspi_l.h

PUBLIC_LIBS = ../API/utils.o ../API/mem-io.o
LIB_FILES =

LIB_OBJS := $(subst .c,.o,$(LIB_FILES))

heat_test: heat_test.o $(LIB_OBJS) $(PUBLIC_LIBS)
# $@: target file name, $^: all prerequisites
	gcc -g -o $@ $^

run: heat_test 
	@echo "You must be in root."
	./heat_test  f0000000

clean:
	rm -rf *.o $(ALL_EXE) 

#pattern rules
%.o: %.c $(DEPS)
# $<: first prerequisite
	$(CC) -g -c -o $@ $< $(CFLAGS)
