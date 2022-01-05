.INCLUDE "./files/utility.s"

.DATA
X:          .FILL 6, 1
Y:          .FILL 1, 1
resto:      .BYTE 0
quoziente:  .BYTE 0
concatena:  .BYTE 0

.TEXT
_main:
        NOP

input_X:
        MOV $6, %CL
        LEA X, %ESI
        CALL leggi_numero

input_Y:
        CALL newline
        MOV $1, %CL
        LEA Y, %ESI
        CALL leggi_numero

check_Y:
        CALL newline
        CALL newline
        MOV $0, %AH
        MOV $0, %ESI        #indice per Y
        MOV $0, %EDI        #indice per X
        MOVB Y(%ESI), %BL
        CMP $0, %BL
        JE fine

print:
        CMP $6, %EDI
        JE resetta
        MOVB X(%EDI), %AL
        # 10r + X
        MOV resto, %DL
        MOV resto, %CL
        SHL $1, %DL
        SHL $3, %CL
        ADD %CL, %DL
        ADD %DL, %AL
        CALL outdecimal_byte
        MOV $'/', %AL
        CALL outchar
        MOV %BL, %AL
        CALL outdecimal_byte
        MOV $':', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOV $'q', %AL
        CALL outchar
        MOV $'=', %AL
        CALL outchar

divisione:
        MOV $0, %AH
        MOVB X(%EDI), %AL
        # 10r + X
        MOV resto, %DL
        MOV resto, %CL
        SHL $1, %DL
        SHL $3, %CL
        ADD %CL, %DL
        ADD %DL, %AL
        
        DIV %BL
        MOV %AH, resto
        MOV %AL, quoziente
        CALL outdecimal_byte
        MOV $',', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOV $'r', %AL
        CALL outchar
        MOV $'=', %AL
        CALL outchar
        MOV resto, %AL
        CALL outdecimal_byte
        CALL newline
        INC %EDI
        JMP print

continua:
        JMP fine

resetta:
        CALL newline
        JMP input_X

leggi_numero:
        CMP $0, %CL
        JE ritorna
        CALL inchar
        CMP $'0', %AL
        JB leggi_numero
        CMP $'9', %AL
        JA leggi_numero
        CALL outchar
        AND $0x0F, %AL
        MOV %AL, (%ESI)
        DEC %CL
        INC %ESI
        JMP leggi_numero
ritorna:
        RET

fine:
        RET
