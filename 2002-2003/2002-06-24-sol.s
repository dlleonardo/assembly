#Scrivere un programma che esegue ciclicamente le seguenti azioni:
#
#1) legge con eco da tastiera una stringa di caratteri terminata da un ritorno carrello;
#2) conta il numero di occorrenze delle stringhe 'pr' e 'ti' nella stringa;
#3) per ciascuna delle stringhe cercate, stampa il numero di occorrenze;
#4) stampa la stringa sostituendo ad ogni occorrenza individuata la stringa '<>'.
#
#Il programma termina quando viene inserita la stringa STOP.
#Esempio.
#
#prova pratica di reti logiche
#pr 2
#ti 2
#<>ova <>a<>ca di re<> logiche

.INCLUDE "./files/utility.s"

.DATA
msg_in:     .FILL 80, 1, 0
count_pr:   .BYTE 0
count_ti:   .BYTE 0

.TEXT
_main:  
        NOP
        MOV $80, %CX
        LEA msg_in, %EBX
        CALL inline
        MOV $0, %ECX
        MOV $0, %ESI
        LEA msg_in, %EBX
        LEA msg_in, %EDI

loop:
        MOV (%EBX), %AL
        CMP $0x0d, %AL
        JE stampa
        CMP $'p', %AL
        JE check_r
        CMP $'t', %AL
        JE check_i
        INC %EBX
        JMP loop

check_r:
        MOV %EBX, %EDI
        INC %EDI
        MOV (%EDI), %AL
        CMP $'r', %AL
        JE inc_pr
        JMP avanti

check_i:
        MOV %EBX, %EDI
        INC %EDI
        MOV (%EDI), %AL
        CMP $'i', %AL
        JE inc_ti
        JMP avanti

inc_pr:
        INC %ECX
        INC %EBX
        JMP loop

inc_ti:
        INC %ESI
        INC %EBX
        JMP loop

avanti:
        INC %EBX
        JMP loop

stampa:
        MOV $'p', %AL
        CALL outchar
        MOV $'r', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOV %CL, %AL
        ADD $'0', %AL
        CALL outchar
        CALL newline
        MOV $'t', %AL
        CALL outchar
        MOV $'i', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOV %ESI, %EAX
        ADD $'0', %AL
        CALL outchar
        CALL newline

stampa_riga:
        LEA msg_in, %EBX

loop_stampa_riga:
        MOV (%EBX), %AL
        CMP $0x0d, %AL
        JE fine
        CMP $'p', %AL
        JE riga_check_r
        CMP $'t', %AL
        JE riga_check_i
        CALL outchar
        INC %EBX
        JMP loop_stampa_riga

riga_check_r:
        MOV %EBX, %ESI
        INC %ESI
        MOV (%ESI), %AL
        CMP $'r', %AL
        JE stampa_simbolo
        JMP inc_loop_stampa_riga

riga_check_i:
        MOV %EBX, %ESI
        INC %ESI
        MOV (%ESI), %AL
        CMP $'i', %AL
        JE stampa_simbolo
        JMP inc_loop_stampa_riga

stampa_simbolo:
        MOV $'<', %AL
        CALL outchar
        MOV $'>', %AL
        CALL outchar
        MOV %ESI, %EBX
        JMP inc_loop_stampa_riga

inc_loop_stampa_riga:
        INC %EBX
        JMP loop_stampa_riga

fine: 
        RET
