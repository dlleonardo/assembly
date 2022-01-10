# 1) legge con eco da tastiera una stringa di caratteri terminata da un
#   ritorno carrello;
# 2) sostituisce nella stringa ogni sequenza di caratteri uguali con il
#   carattere stesso;
# 3) stampa la stringa risultante.
# 4) stampa il numero di sostituzioni effettuate;
# Il programma termina quando viene inserita la stringa STOP.
# Esempio
# aaaghii     ffsdi uu
# aghi fsdi u
.INCLUDE "./files/utility.s"

.DATA
msg:        .FILL 80, 1, 0

.TEXT
_main: 
        NOP

input:
        MOV $80, %CX
        LEA msg, %EBX
        CALL inline
        CALL newline
        MOV $0, %CL         # numero sostituzioni

check_stringa:
        LEA msg, %ESI
        LEA msg, %EDI
        INC %EDI

loop_check:
        MOVB (%ESI), %AL
        CMP $0x0d, %AL
        JE stampa_occorrenze
        MOVB (%EDI), %BL
        CMP %AL, %BL
        JE next_char

stampa_carattere:
        MOV %EDI, %EDX
        SUB %ESI, %EDX
        CMP $1, %EDX
        JA incrementa

stampa_carattere_finale:
        CALL outchar
        MOV %EDI, %ESI
        INC %EDI
        JMP loop_check

incrementa:
        INC %CL
        JMP stampa_carattere_finale

next_char:
        INC %EDI
        JMP loop_check

stampa_occorrenze:
        MOV %CL, %AL
        CALL newline
        CALL outdecimal_byte

termina:
        RET
