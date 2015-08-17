
LB=m68k-atari-mint-lb
LD=m68k-atari-mint-ld
AS=m68k-atari-mint-as

AFLAGS=-l 
CFLAGS= -Os -c
#include 680x0.mk
#include g++.mk
#include gcc.mk
# LFLAGS=-m -u -ws -b .text=0x0 
LFLAGS= -oformat=srec
CC=m68k-atari-mint-gcc
CPP=m68k-atari-mint-g++

BINS  = hello.bin
OBJS  = $(BINS:.bin=.o) *crt0.o
CRT0  = $(BINS:.bin=crt0.o)
LSTS  = $(BINS:.bin=.lst) *crt0.lst
CLST  = $(BINS:.bin=crt0.lst)
MAPS  = $(BINS:.bin=.map)
ROMS  = $(BINS:.bin=.rom)
RAMS  = $(BINS:.bin=.ram)
ASRC  = $(BINS:.bin=.s) *crt0.s

CLEAN_LIST= $(CRT0) $(ASRC) $(OBJS) $(LSTS) $(CLST) $(MAPS) *~ $(RAMS) $(ROMS)

.PHONY: clean all

all: $(BINS)

hello.bin: hellocrt0.o hello.o
	$(LD) $(LFLAGS) hellocrt0.o hello.o -o hello.bin

hellocrt0.o: hellocrt0.s
	$(AS) $(AFLAGS) hellocrt0.s -o hellocrt0.o

hellocrt0.s: crt0.tpl
	cat crt0.tpl | sed -e s/XXX/`echo $* | sed -e "s/crt0//" | tr '[:lower:]' '[:upper:]'`/ > hellocrt0.s

clean:
	$(RM) $(CLEAN_LIST)

.s.o:
	$(AS) $(AFLAGS) $<

.c.s:
	$(CC) $< $(CFLAGS) $* -S
