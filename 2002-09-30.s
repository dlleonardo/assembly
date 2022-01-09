# Scrivere un programma che si comporta come segue:
# 1)  legge con eco da tastiera una stringa di al piu 20 cifre ([0-9])
#      terminata da un ritorno carrello;
# 2.a) se la stringa e` vuota, termina; altrimenti
# 2.b) riordina le cifre nella stringa in ordine crescente;
# 3)  stampa la stringa risultante e torna al punto 1.

.INCLUDE "./files/utility.s"

.DATA
msg:        .FILL 22, 1, 0

.TEXT
_main:
        NOP

input:
        MOV $22, %CX
        LEA msg, %EBX
        CALL inline

check_str:
        LEA msg, %ESI
        LEA msg, %EDI
        INC %EDI

loop_str:
        MOVB (%ESI), %AL
        CMP $0x0d, %AL
        JE stampa
        MOVB (%EDI), %BL
        CMP $0x0d, %BL
        JE prossimo_elemento
        CMP %BL, %AL
        JA scambia
        INC %EDI
        JMP loop_str

scambia:
        MOVB %BL, (%ESI)
        MOVB %AL, (%EDI)
        INC %EDI
        JMP loop_str

prossimo_elemento:
        INC %ESI
        MOV %ESI, %EDI
        INC %EDI
        JMP loop_str

stampa:
        LEA msg, %ESI
        CALL newline

loop_stampa:
        MOVB (%ESI), %AL
        CMP $0x0d, %AL
        JE termina
        CALL outchar
        INC %ESI
        JMP loop_stampa

termina:
        RET
