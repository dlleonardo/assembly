.INCLUDE "./files/utility.s"

.DATA
N:      .BYTE 0
k:      .BYTE 0
aux:    .BYTE 1

.TEXT
_main:
        NOP
        
input_N:
        CALL inchar
        CMP $'0', %AL
        JE fine
        JB input_N
        CMP $'9', %AL
        JA input_N
        CALL outchar
        SUB $'0', %AL
        MOV %AL, N
        CALL newline

input_k:
        CALL inchar
        CMP $'0', %AL
        JB input_k
        CMP $'9', %AL
        JA input_k
        CALL outchar
        SUB $'0', %AL
        MOV %AL, k
        CALL newline        
        MOV $1, %CL

print:
        CMP $1, %CL
        JE print_1
        MOV N, %BL
        CMP %CL, %BL
        JB fine
        MOV %CL, %BL

loop:
        CMP $0, %BL
        JE continua
        MOV aux, %AL
        MOV k, %DL
        ADD %DL, %AL
        MOV %AL, aux
        CALL outdecimal_byte
        MOV $' ', %AL
        CALL outchar
        DEC %BL
        JMP loop

continua:
        INC %CL
        CALL newline
        JMP print

print_1:
        MOV $1, %AL
        CALL outdecimal_byte
        MOV k, %DL
        ADD %DL, %AL
        CALL newline
        INC %CL
        JMP print

fine:
        RET
