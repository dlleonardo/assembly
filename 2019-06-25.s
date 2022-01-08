# Scrivere un programma che si comporta come segue:
# 1. emette ? e legge con eco da tastiera un numero naturale in base dieci 
#    che sta su un byte;
# 2. se il numero è compreso fra 0 e 19:
#     a. stampa su una nuova riga il nome del numero;
#     b. torna al punto 1;
# 3. altrimenti, se il numero è maggiore di 19, termina.
#
# Esempio:
# 13
# tredici
# 0
# zero
# 214
.INCLUDE "./files/utility.s"

.DATA
numero:         .FILL 2, 1
zero:           .ASCII "zero"
uno:            .ASCII "uno"
due:            .ASCII "due"
tre:            .ASCII "tre"
quattro:        .ASCII "quattro"
cinque:         .ASCII "cinque"
sei:            .ASCII "sei"
sette:          .ASCII "sette"
otto:           .ASCII "otto"
nove:           .ASCII "nove"
dieci:          .ASCII "dieci"
undici:         .ASCII "undici"
dodici:         .ASCII "dodici"
tredici:        .ASCII "tredici"
quattordici:    .ASCII "quattordici"
quindici:       .ASCII "quindici"
sedici:         .ASCII "sedici"
diciasette:     .ASCII "diciasette"
diciotto:       .ASCII "diciotto"
diciannove:     .ASCII "diciannove"
lunghezze:      .BYTE 4, 3, 3, 3, 7, 6, 3, 5, 4, 4, 5, 6, 6, 7, 11, 8, 6, 10, 8, 10
numeri:         .LONG zero, uno, due, tre, quattro, cinque, sei, sette, otto, nove, dieci, undici, dodici, tredici, quattordici, quindici, sedici, diciasette, diciotto, diciannove

.TEXT
_main:
        NOP

input:
        LEA numero, %ESI
        MOV $2, %CL
        CALL leggi_numero

check_numero:
        LEA numero, %ESI
        MOV $0, %EAX
        CALL converti_numero
        CMP $0, %AL
        JB termina
        CMP $19, %AL
        JA termina
        CALL newline

stampa_numero:
        MOV $0, %ECX
        # %AL contiene indice del numero da stampare di numeri(%EAX), lunghezze(%EAX) contiene numeri carattere
        MOVB lunghezze(%EAX), %CL
        MOVL numeri(,%EAX, 4), %EBX
        CALL outmess
        CALL input

converti_numero:
        # 2*n1 + 8*n1 + n0
        MOVB (%ESI), %AL
        MOVB (%ESI), %BL
        SHL $1, %AL
        SHL $3, %BL
        ADD %BL, %AL
        INC %ESI
        MOV (%ESI), %BL
        ADD %BL, %AL
        JMP termina

leggi_numero:
        CMP $0, %CL
        JE termina
        CALL inchar
        CMP $'0', %AL
        JB leggi_numero
        CMP $'9', %AL
        JA leggi_numero
        AND $0x0F, %AL
        MOVB %AL, (%ESI)
        INC %ESI
        DEC %CL
        JMP leggi_numero

termina:
        RET
