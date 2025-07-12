.include "/data/data/com.termux/files/home/storage/shared/fwc-1/assembly/m328Pdef.inc"

Start:

ldi r17, 0b00000001
out DDRD, r17  ;0

ldi r26, 0b11110000
out DDRB, r26
andi r16, 0b00001111	
in r16, PINB  ; 8,9,10,11

mov r18, r16
andi r18, 0b00001000  ;D
lsr r18
lsr r18
lsr r18

mov r19, r16
andi r19, 0b00000100  ;C
lsr r19
lsr r19

mov r20, r16
andi r20, 0b00000010  ; B
lsr r20

mov r21, r16
andi r21, 0b00000001 ;A



ldi r31, 0b00000001

mov r22,r18
eor r22,r31  ;!D

mov r23,r21
eor r23,r31  ;!A


mov r24, r20
eor r24, r19  ;B xor C

and r24, r22

and r24, r21

and r24, r23

or r24, r18


andi r24, 0x01
out PORTD, r24
rjmp Start
