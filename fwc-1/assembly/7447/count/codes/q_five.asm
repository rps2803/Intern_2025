Start:


.include "/m328Pdef.inc"


ldi r16, 0b11000011
out DDRB, r16      ;10,11,12,13 as ip
in r16, PINB
andi r16, 0b00111100 

ldi r17, 0b00111100
out DDRD, r17

mov r19,r16     ;z
andi r19, 0b00100000
lsr r19
lsr r19
lsr r19
lsr r19
lsr r19


mov r20,r16   ;y
andi r20, 0b00010000
lsr r20
lsr r20
lsr r20
lsr r20


mov r21,r16    ;x       
andi r21,0b00001000
lsr r21
lsr r21
lsr r21

mov r22,r16    ;w
andi r22, 0b00000100
lsr r22
lsr r22



ldi r24, 0b00000001

mov r31,r19
eor r31,r24     ; !Z

mov r30,r20
eor r30,r24     ;!y

mov r29, r21
eor r29,r24    ;  !x

mov r28, r22
eor r28, r24   ; !w




mov r5,r28    ;A

mov r6, r22    ;B
and r6,r29
and r6, r31
mov r7, r28
and r7, r21
or r6,r7


mov r7,r22     ;C

and r7,r21
and r7,r30
mov r8,r29
and r8,r20
mov r9,r28
and r9,r20
or r9,r8
or r7,r9

mov r8,r22     ;D
and r8,r21
and r8,r20
mov r9,r28
and r9,r19
or r8,r9


clr r1
clr r2
clr r3
clr r4

mov r1,r8
lsl r1
lsl r1
lsl r1

mov r2,r7
lsl r2
lsl r2

mov r3,r6
lsl r3

mov r4,r5

or r1,r4
or r1,r2
or r1,r3

mov r17,r1
andi r17, 0x0F
out PORTD, r17


rjmp Start

