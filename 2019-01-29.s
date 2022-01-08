#Scrivere un programma che si comporta come segue:
#
#1. legge con eco da tastiera una stringa di lettere minuscole 
#   terminata da ritorno carrello;
#2. legge con eco da tastiera una lettera minuscola;
#3. stampa sulla riga il numero di occorrenze nella stringa della lettera;
#4. se il numero di occorrenze Ã¨ maggiore di uno torna al passo 2, altrimenti termina.
#
#Esempio:
#aabcdddhbbc
#a 2
#d 3
#f 0
.INCLUDE "./files/utility.s"

.DATA
msg:        .FILL 80, 1
occorrenze: .FILL 26, 1, 0

.TEXT
_main:
        NOP

input_msg:
        MOV $0, %EAX
        MOV $80, %CX
        LEA msg, %EBX
        CALL inline

input_lettera:
        CALL newline
        CALL inchar
        MOV %AL, %DL
        CALL newline

check_lettera:
        LEA msg, %ESI

loop_check_lettera:
        MOVB (%ESI), %AL
        CMP $0x0d, %AL
        JE stampa_occorrenze
        CMP %AL, %DL
        JE conta
        INC %ESI
        JMP loop_check_lettera

conta:
        SUB $'a', %AL
        INCB occorrenze(%EAX)
        INC %ESI
        JMP loop_check_lettera

stampa_occorrenze:
        MOV $0, %EAX
        MOV %DL, %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOV %DL, %AL
        SUB $'a', %AL
        MOVB occorrenze(%EAX), %DL
        MOV %DL, %AL
        CALL outdecimal_byte
        CALL newline
        CMP $0, %AL
        JE termina
        JMP input_lettera

termina:
        RET
