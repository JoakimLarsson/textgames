/*----------------------------------------------------------------------------
        crt0.s originally by Paul Andrews,
        copied from https://gcc.gnu.org/ml/gcc-help/1999-11n/msg00424.html
        and modified by Joakim Larsson Edstrom, 2015-08-12
  ----------------------------------------------------------------------------*/
        .extern main
        .extern _etext
        .extern _edata
        .extern _sdata
        .global start

/*----------------------------------------------------------------------------*/
/*
ramstart:       
        .ds.b   4096
stktop:
*/


vectors:        
        .org 0xa0000

        .long _etext
        .long start
/*----------------------------------------------------------------------------*/
        .text

        .global ___main 
        .global _printf
        .global _sdata

___main: 
        rts
start:
/*        move.l  #stktop,%a7      set up the stack */
        move.l  #4096,%a7       /* set up the stack */

        move.l  #_etext,%a0     /* copy initialised data back to ram */
        move.l  #_sdata,%a1

loop:
        move.b  (%a0)+,(%a1)+
        cmp.l   #_edata,%a1
        blt.s   loop

        jmp     _main

_printf:
        rts;

_sdata:


/*----------------------------------------------------------------------------*/
        /* EOF  */
