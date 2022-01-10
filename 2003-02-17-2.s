# 1. legge con eco da tastiera, facendo opportuni controlli, una stringa di ESATTAMENTE
#    dieci caratteri alfabetici maiuscoli;
# 2. se la stringa non è vuota, stampa su una nuova riga una stringa ottenuta dalla precedente scambiando ogni carattere in posizione dispari 
#    con il successivo in posizione pari, e cambiando tutte le vocali da maiuscolo a minuscolo, quindi TORNA AL PUNTO 1. Altrimenti,
# 3. se la stringa è vuota, termina.
# Esempio:
# ABCDEFGHIL
# BaDCFeHGLi
.INCLUDE "./files/utility.s"

.DATA
msg:        .FILL 10, 1, 0

.TEXT
_main:
        NOP

input:
        MOV $10, %CL
        LEA msg, %ESI
        CALL leggi_stringa

check:
        MOV $0, %ESI
        MOV $1, %EDI
        MOV $10, %CL

loop_check:
        MOVB msg(%ESI), %AL         # esi indice pari
        CMP $0x0d, %AL
        JE termina
        MOVB msg(%EDI), %BL         # edi indice dispari
        # controllo vocali in AL, BL
        CALL check_vocali
        PUSH %EAX
        MOV %BL, %AL
        CALL check_vocali
        MOV %AL, %BL
        POP %EAX
        MOVB %AL, msg(%EDI)
        MOVB %BL, msg(%ESI)
        ADD $2, %ESI
        ADD $2, %EDI
        CMP $10, %ESI
        JE stampa
        JMP loop_check

stampa:
        LEA msg, %EBX
        MOV $10, %CX
        CALL newline
        CALL outmess
        CALL newline
        JMP input

check_vocali:
        CMP $'A', %AL
        JE converti
        CMP $'E', %AL
        JE converti
        CMP $'I', %AL
        JE converti
        CMP $'O', %AL
        JE converti
        CMP $'U', %AL
        JE converti
        JMP termina

converti:
        OR $0x20, %AL
        JMP termina

leggi_stringa:
        CMP $0, %CL
        JE termina
        CALL inchar
        CMP $'A', %AL
        JB leggi_stringa
        CMP $'Z', %AL
        JA leggi_stringa
        CALL outchar
        MOVB %AL, (%ESI)
        INC %ESI
        DEC %CL
        JMP leggi_stringa

termina:
        RET
