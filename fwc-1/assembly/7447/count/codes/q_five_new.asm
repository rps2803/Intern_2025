
.include "/m328Pdef.inc"

Start:
    ; Set PB2–PB5 as inputs (bits 2–5), others as output
    ldi r16, 0b11000011
    out DDRB, r16

    ; Read PINB and mask input bits
    in r16, PINB
    ldi r17, 0b00111100
    and r16, r17              ; Mask PB2 to PB5

    ; Extract Z (PB5)
    mov r18, r16
    lsr r18
    lsr r18
    lsr r18
    lsr r18
    lsr r18                  ; r18 = Z
    andi r18, 0x01

    ; Extract Y (PB4)
    mov r19, r16
    lsr r19
    lsr r19
    lsr r19
    lsr r19                  ; r19 = Y
    andi r19, 0x01

    ; Extract X (PB3)
    mov r20, r16
    lsr r20
    lsr r20
    lsr r20                  ; r20 = X
    andi r20, 0x01

    ; Extract W (PB2)
    mov r21, r16
    lsr r21
    lsr r21                  ; r21 = W
    andi r21, 0x01

    ; Compute complements Z̅ Y̅ X̅ W̅
    ldi r22, 0x01
    eor r22, r18             ; r22 = Z̅

    ldi r23, 0x01
    eor r23, r19             ; r23 = Y̅

    ldi r24, 0x01
    eor r24, r20             ; r24 = X̅

    ldi r25, 0x01
    eor r25, r21             ; r25 = W̅

    ; A = Z̅
    mov r26, r22             ; r26 = A

    ; B = W.X̅.Z̅ + X.Y̅
    mov r27, r21             ; W
    and r27, r24             ; W & X̅
    and r27, r22             ; & Z̅

    mov r28, r20             ; X
    and r28, r23             ; & Y̅
    or r27, r28              ; r27 = B

    ; C = W.X.Y̅ + (Y.X̅ + Y.Z̅)
    mov r29, r21
    and r29, r20             ; W & X
    and r29, r23             ; & Y̅

    mov r30, r19
    and r30, r24             ; Y & X̅

    mov r31, r19
    and r31, r22             ; Y & Z̅

    or r30, r31              ; (Y.X̅ + Y.Z̅)
    or r29, r30              ; r29 = C

    ; D = W.X.Y.Z̅
    mov r16, r21
    and r16, r20             ; W & X
    and r16, r19             ; & Y
    and r16, r22             ; & Z̅
    ; r16 = D

    ; Combine into 4-bit output: D C B A
    lsl r16                  ; D << 1
    lsl r16                  ; << 2
    lsl r16                  ; << 3

    mov r17, r29             ; C
    lsl r17
    lsl r17                  ; C << 2
    or r16, r17

    mov r17, r27             ; B
    lsl r17                  ; B << 1
    or r16, r17

    or r16, r26              ; + A

    ; Output result to PORTD
    andi r16, 0x0F
    out PORTD, r16

    rjmp Start
