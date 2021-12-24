#Scrivere un programma che si comporta come segue:
#
#1. legge con eco da tastiera una riga terminata da Ritorno Carrello e di
#   lunghezza massima 40 caratteri;
#
#2. conta le occorrenze di ciascuna CIFRA DECIMALE che compare nella riga;
#
#3. per ogni cifra che compare almeno una volta, stampa su una riga sepa-
#   rata la cifra seguita dal numero di occorrenze, quindi torna al passo 1.

.INCLUDE "./files/utility.s"

.DATA
msg_in:     .FILL 40, 1, 0
conteggio:  .FILL 10, 1, 0

.TEXT
_main:
        NOP
        MOV $40, %CX
        LEA msg_in, %EBX
        CALL inline
        MOV $0, %EAX
        LEA msg_in, %EDI

loop:
        MOV (%EDI), %AL
        CMP $0x0d, %AL
        JE print
        CMP $'0', %AL
        JB avanti
        CMP $'9', %AL
        JA avanti
        SUB $'0', %AL
        INCB conteggio(%EAX)

avanti:
        INC %EDI
        JMP loop

print:
        MOV $0, %EDX
        MOV $0, %EBX

loop_print:
        CMP $10, %EDX
        JE fine
        MOVB conteggio(%EDX), %BL
        CMP $0, %BL
        JE avanza_print
        MOV %DL, %AL
        ADD $'0', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOV %BL, %AL
        ADD $'0', %AL
        CALL outchar
        CALL newline

avanza_print:
        INC %EDX
        JMP loop_print

fine:
        RET
