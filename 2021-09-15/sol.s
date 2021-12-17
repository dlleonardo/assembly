.INCLUDE "./files/utility.s"

.DATA
messaggio:  .FILL 80, 1, 0
conteggio:  .FILL 16, 1, 0

.TEXT
_main:
        NOP
        MOV $80, %ECX
        LEA messaggio, %EBX
        CALL inline

        MOV $0, %ECX
        MOV $0, %EAX
        LEA messaggio, %ESI
        
check_0_9:
        MOVB (%ESI), %AL
        
        CMP $0x0d, %AL
        JE stampa_0_9
        
        CMP $'0', %AL
        JB check_a_f
        CMP $'9', %AL
        JA check_a_f
        SUB $'0', %AL
        INCB conteggio(%EAX)
        INC %ESI
        JMP check_0_9

check_a_f:
        CMP $'a', %AL
        JB check_A_F
        CMP $'z', %AL
        JA check_A_F
        SUB $'a', %AL
        ADD $10, %AL
        INCB conteggio(%EAX)
        INC %ESI
        JMP check_0_9

check_A_F:
        CMP $'A', %AL
        JB check_A_F
        CMP $'Z', %AL
        JA check_A_F
        SUB $'A', %AL
        ADD $10, %AL
        INCB conteggio(%EAX)
        INC %ESI
        JMP check_0_9

stampa_0_9:
        CMP $10, %ECX
        JE stampa_a_f
        MOVB conteggio(%ECX), %AL
        MOV %AL, %BL
        CMP $0, %AL
        JE continua
        MOV %ECX, %EAX
        ADD $'0', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOV %BL, %AL
        ADD $'0', %AL
        CALL outchar
        CALL newline

continua:
        INC %ECX
        JMP stampa_0_9

stampa_a_f:
        CMP $16, %ECX
        JE fine
        MOVB conteggio(%ECX), %AL
        MOV %AL, %BL
        CMP $0, %AL
        JE continua_a_f
        MOV %ECX, %EAX
        SUB $10, %EAX
        ADD $'a', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOV %BL, %AL
        ADD $'0', %AL
        CALL outchar
        CALL newline

continua_a_f:
        INC %ECX
        JMP stampa_a_f

fine:
        RET
