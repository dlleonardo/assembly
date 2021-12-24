#Scrivere un programma che si comporta come segue:
#
#1. legge con eco da tastiera una riga terminata da Ritorno Carrello e di lunghezza
#   massima 40 caratteri;
#2. per ciascuna CIFRA ESADECIMALE che compare almeno una volta nella riga, stampa su una
#   riga separata la cifra seguita dal numero di volte che compare;
#3. se nella riga non ci sono cifre esadecimali termina, altrimenti torna al passo 1.

.INCLUDE "./files/utility.s"

.DATA
msg_in:     .FILL 40, 1, 0
conteggio:  .FILL 15, 1, 0

.TEXT
_main:
        NOP
        MOV $40, %CX
        LEA msg_in, %EBX
        CALL inline
        MOV $0, %EAX
        LEA msg_in, %EBX

loop_0_9:
        MOVB (%EBX), %AL
        CMP $0x0d, %AL
        JE stampa
        CMP $'0', %AL
        JB loop_a_f
        CMP $'9', %AL
        JA loop_a_f
        SUB $'0', %AL
        INCB conteggio(%EAX)
        INC %EBX
        JMP loop_0_9

loop_a_f:
        CMP $'a', %AL
        JB loop_A_F
        CMP $'f', %AL
        JA loop_A_F
        SUB $'a', %AL
        ADD $10, %AL
        INCB conteggio(%EAX)
        INC %EBX
        JMP loop_0_9

loop_A_F:
        CMP $'A', %AL
        JB avanti
        CMP $'F', %AL
        JA avanti
        SUB $'A', %AL
        ADD $10, %AL
        INCB conteggio(%EAX)
        INC %EBX
        JMP loop_0_9

avanti:
        INC %EBX
        JMP loop_0_9

stampa:
        CMP $0, conteggio
        JE fine
        MOV $0, %EBX

loop_stampa_0_9:
        CMP $10, %EBX
        JE loop_stampa_a_f 
        MOV %BL, %AL
        ADD $'0', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOVB conteggio(%EBX), %AL
        ADD $'0', %AL
        CALL outchar
        CALL newline
        INC %EBX
        JMP loop_stampa_0_9

loop_stampa_a_f:
        CMP $16, %EBX
        JE fine
        MOV %BL, %AL
        SUB $10, %AL
        ADD $'a', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOVB conteggio(%EBX), %AL
        ADD $'0', %AL
        CALL outchar
        CALL newline
        INC %EBX
        JMP loop_stampa_a_f

fine:
        RET
