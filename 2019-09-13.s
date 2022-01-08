# ------------------------------------------------------------------------
# Scrivere un programma che si comporta come segue:
#
# 1. legge con eco da tastiera una sequenza di cinque cifre binarie, da interpretare come
#    la rappresentazione di un numero intero n in complemento a due. Il programma deve fare
#    i necessari controlli in modo da accettare SOLTANTO le codifiche ASCII di ESATTAMENTE
#    5 cifre binarie;
# 2. se n Ã¨ positivo, stampa la riga
#    n = <+...+>
#    altrimenti, se n Ã¨ negativo, stampa la riga:
#    n = <-...->
#    dove il numero di caratteri '+' o '-' Ã¨ uguale a ABS(n);
# 3. se n Ã¨ uguale a zero termina, altrimenti torna al passo 1.
#
# ------------------------------------------------------------------------
.INCLUDE "./files/utility.s"

.DATA
cifre:          .FILL 5, 1, 0

.TEXT
_main:
        NOP
        
input_cifre:
        LEA cifre, %ESI
        MOV $5, %CL
        CALL leggi_cifre
        CALL newline

check_cifre:
        # an-1 = 0 -> A
        # an-1 = 1 -> (~A + 1)
        LEA cifre, %ESI
        MOVB (%ESI), %AL
        CMP $0, %AL
        JE stampa_positivo
        JMP stampa_negativo

stampa_finale:
        # %DL = numero di + da stampare se > 0
        CMP $0, %DL
        JE termina
        MOV $'<', %AL
        CALL outchar        

loop_stampa_finale:
        CMP $0, %DL
        JE stampa_finale_2
        MOV $'+', %AL
        CALL outchar
        DEC %DL
        JMP loop_stampa_finale

stampa_finale_2:
        MOV $'>', %AL
        CALL outchar
        CALL newline
        JMP input_cifre

stampa_negativo:
        CALL converti_base_10
        NOT %DL
        INC %DL
        XOR $0xE0, %DL
        JMP stampa_finale_negativo

stampa_finale_negativo:
        MOV $'<', %AL
        CALL outchar

loop_stampa_negativo:
        CMP $0, %DL
        JE stampa_finale_2
        MOV $'-', %AL
        CALL outchar
        DEC %DL
        JMP loop_stampa_negativo        

stampa_positivo:
        CALL converti_base_10
        JMP stampa_finale

converti_base_10:
        MOV $0, %EDI
        MOV $0, %AH
        MOV $0, %DL
        MOV $4, %CL
loop_converti:
        # 2^4*n4 + 2^3*n3 + 2^2*n2 + 2^1*n1 + 2^0*n0
        MOVB cifre(%EDI), %AL
        SHL %CL, %AL
        ADD %AL, %DL    # DL = totale
        INC %EDI
        DEC %CL
        CMP $5, %EDI
        JE termina
        JMP loop_converti

leggi_cifre:
        CMP $0, %CL
        JE termina
        CALL inchar
        CMP $'0', %AL
        JB leggi_cifre
        CMP $'1', %AL
        JA leggi_cifre
        CALL outchar
        AND $0x0F, %AL
        MOVB %AL, (%ESI)
        INC %ESI
        DEC %CL
        JMP leggi_cifre

termina:
        RET
