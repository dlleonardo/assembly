#Scrivere un programma che:
#1. legge con eco da tastiera una stringa di max 20 caratteri terminata
#   da un ritorno carrello;
#2. legge con eco un singolo carattere;
#3. stampa su una nuova riga la stringa ottenuta da quella letta al
#   passo 1 sostituendo con il carattere '*' tutte le occorrenze del
#   carattere letto al passo 2 .
#4. se la stringa inserita e` diversa da "FINE" va al passo 1,
#   altrimenti termina.
#
#Esempio:
#	prova pratica di reti logiche 
#	a
#	prov* pr*tic* di reti logiche 

.INCLUDE "./files/utility.s"

.DATA
msg_in:     .FILL 20, 1, 0

.TEXT
_main:
        NOP
        MOV $20, %CX
        LEA msg_in, %EBX
        CALL inline
        CALL inchar
        MOV %AL, %BL
        CALL outchar
        CALL newline
        LEA msg_in, %EDI

print:
        MOV (%EDI), %AL
        CMP $0x0d, %AL
        JE fine
        CMP %AL, %BL
        JNE print_senza
        MOV $'*', %AL

print_senza:
        CALL outchar
        INC %EDI
        JMP print

fine:
        RET
