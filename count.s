# Count the occurences number in array, then print

.INCLUDE "./files/utility.s"

.DATA
array:      .WORD 1, 256, 256, 512, 42, 2048, 1024, 1, 0
array_len:  .LONG 9
number:     .WORD 512

.TEXT
_main:
        NOP
        MOV $0, %CL
        MOV $0, %ESI
        MOV number, %AX

loop:
        CMP array_len, %ESI
        JE print
        CMP array(, %ESI, 2), %AX
        JNE continue
        INC %CL

continue:
        INC %ESI
        JMP loop

print:
        MOV %CL, %AL
        CALL outdecimal_byte
        RET
