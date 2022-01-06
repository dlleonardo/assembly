.INCLUDE "./files/utility.s"

.DATA
A:      .FILL 2, 1
B:      .FILL 2, 1
numA:   .BYTE 0
numB:   .BYTE 0

.TEXT
_main:
        NOP

input_A:
        LEA A, %ESI
        MOV $2, %CL
        CALL input_numero
        CALL newline

input_B:
        LEA B, %ESI
        MOV $2, %CL
        CALL input_numero
        CALL newline

converti_A:
        LEA A, %ESI
        CALL converti_numero
        CMP $2, %AL
        JBE termina
        CMP $20, %AL
        JAE termina
        MOV %AL, numA

converti_B:
        LEA B, %ESI
        CALL converti_numero
        CMP $2, %AL
        JBE termina
        CMP $20, %AL
        JAE termina
        MOV %AL, numB

check_A_B:
        CALL newline
        MOV numA, %AL
        MOV numB, %BL
        MOV numB, %DL
        MOV numA, %CL
        CMP %AL, %BL
        JBE rect_0_1
        JMP rect_1_0

rect_0_1:
        # A base, %AL, A colonne
        # B altezza, %BL, B righe
        CMP $0, %BL
        JE input_A

        CMP $0, %AL
        JE avanti

stampa:
        CMP $1, %BL     # prima riga
        JE stampa_0
        CMP %DL, %BL    # ultima riga
        JE stampa_0
        CMP $1, %AL     # ultimo elemento di riga
        JE stampa_0
        CMP %CL, %AL    # primo elemento di riga
        JE stampa_0
        PUSH %EAX
        MOV $'1', %AL
        CALL outchar
        POP %EAX
        DEC %AL
        JMP rect_0_1

stampa_0:
        PUSH %EAX
        MOV $'0', %AL
        CALL outchar
        POP %EAX
        DEC %AL
        JMP rect_0_1

avanti:
        CALL newline
        MOV numA, %AL
        DEC %BL
        JMP rect_0_1

rect_1_0:
        CMP $0, %BL
        JE input_A
        CMP $0, %AL
        JE avanti_2

stampa_2:
        CMP $1, %BL     # prima riga
        JE stampa_1
        CMP %DL, %BL    # ultima riga
        JE stampa_1
        CMP $1, %AL     # ultimo elemento di riga
        JE stampa_1
        CMP %CL, %AL    # primo elemento di riga
        JE stampa_1
        PUSH %EAX
        MOV $'0', %AL
        CALL outchar
        POP %EAX
        DEC %AL
        JMP rect_1_0

stampa_1:
        PUSH %EAX
        MOV $'1', %AL
        CALL outchar
        POP %EAX
        DEC %AL
        JMP rect_1_0
        

avanti_2:
        CALL newline
        MOV numA, %AL
        DEC %BL
        JMP rect_1_0


converti_numero:
        # 2n1 + 8n1 + n0
        MOVB (%ESI), %AL
        MOVB (%ESI), %BL
        SHL $1, %AL
        SHL $3, %BL
        ADD %BL, %AL
        INC %ESI
        MOVB (%ESI), %BL
        ADD %BL, %AL
        JMP termina

input_numero:
        CMP $0, %CL
        JE termina
        CALL inchar
        CMP $'0', %AL
        JB input_numero
        CMP $'9', %AL
        JA input_numero
        CALL outchar
        AND $0x0F, %AL
        MOVB %AL, (%ESI)
        INC %ESI
        DEC %CL
        JMP input_numero

termina:
        RET
