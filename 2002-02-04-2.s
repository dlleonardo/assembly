# 1. legge con eco da tastiera una sequenza di quattro cifre binarie, da interpretare come la rappresentazione di un numero naturale in base due. Il programma deve fare i necessari controlli in modo da accettare SOLTANTO le codifiche ASCII di ESATTAMENTE 4 cifre binarie;
# 2. se il numero rappresentato è diverso da zero, stampa su una nuova riga il nome del
#    numero in linguaggio naturale, e torna al passo 1. Altrimenti termina.
# Esempio:
# 0111
# sette
# 1010
# dieci
# 0000
.INCLUDE "./files/utility.s"

.DATA
zero:           .ASCII "zero\r"
uno:            .ASCII "uno\r"
due:            .ASCII "due\r"
tre:            .ASCII "tre\r"
quattro:        .ASCII "quattro\r"
cinque:         .ASCII "cinque\r"
sei:            .ASCII "sei\r"
sette:          .ASCII "sette\r"
otto:           .ASCII "otto\r"
nove:           .ASCII "nove\r"
dieci:          .ASCII "dieci\r"
undici:         .ASCII "undici\r"
dodici:         .ASCII "dodici\r"
tredici:        .ASCII "tredici\r"
quattordici:    .ASCII "quattordici\r"
quindici:       .ASCII "quindici\r"
numeri:         .LONG zero, uno, due, tre, quattro, cinque, sei, sette, otto, nove, dieci, undici, dodici, tredici, quattordici, quindici
cifre:          .FILL 4, 1, 0

.TEXT
_main:
        NOP

input:
        LEA cifre, %EBX
        MOV $4, %CL
        CALL leggi_cifre

converti:
        CALL newline
        LEA cifre, %ESI
        MOV $4, %BL
        MOV $3, %CL
        MOV $0, %EDX

loop_converti:
        # 2^3*n3 + 2^2*n2 + 2^1*n1 + 2^0*n0
        CMP $0, %BL
        JE stampa
        MOV (%ESI), %AL
        SHL %CL, %AL
        ADD %AL, %DL        # DL = totale
        DEC %CL
        DEC %BL
        INC %ESI
        JMP loop_converti

stampa:
        CMP $0, %EDX
        JE termina
        MOVL numeri(,%EDX, 4), %EBX
        CALL outline
        CALL newline
        JMP input

leggi_cifre:
        CMP $0, %CL
        JE termina 
        CALL inchar
        CMP $'0', %AL
        JB leggi_cifre
        CMP $'1', %AL
        JA leggi_cifre
        CALL outchar
        AND $0x0F, %AL
        MOV %AL, (%EBX)
        INC %EBX
        DEC %CL
        JMP leggi_cifre

termina:
        RET
