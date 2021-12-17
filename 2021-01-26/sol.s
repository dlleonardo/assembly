.INCLUDE "./files/utility.s"

/* 
   A, B [0;99] 
   a, b [-50;+49] 
*/

.DATA
A:      .BYTE 0
B:      .BYTE 0
C:      .BYTE 0
a:      .BYTE 0
b:      .BYTE 0
c:      .BYTE 0

.TEXT
_main:
        NOP

input_A:
        CALL indecimal_byte
        CALL newline
        MOV %AL, A

input_B:
        CALL indecimal_byte
        CALL newline
        MOV %AL, B

calcolo_a:
        MOV A, %AL
        MOV $100, %BL
        SUB %AL, %BL
        NEG %BL
        MOV %BL, a

calcolo_b:
        MOV B, %AL
        MOV $100, %BL
        SUB %AL, %BL
        NEG %BL
        MOV %BL, b 

somma:
        MOV a, %AL
        MOV b, %BL
        ADD %AL, %BL 
        MOV %BL, c 
        ADD $100, %BL
        MOV %BL, %AL
        CMP $0, %AL
        JBE fine
        CMP $100, %AL
        JAE fine
        CALL outdecimal_byte

continua:
        CALL newline
        CALL input_A

fine:   
        RET
