SRCS=$(wildcard *.asm)
OBJS=$(SRCS:.asm=.s19)

all: $(OBJS)

%.s19: %.asm
	../motorola-6800-assembler/bin/as0 $*.asm -l crc c s

clean:
	rm *.s19
