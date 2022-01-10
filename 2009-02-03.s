# 1) richiede in ingresso un numero intero x in base 10 a 5 cifre,
#    rappresentato in MODULO E SEGNO, svolgendo gli opportuni controlli,
#    ed assumendo che ABS(x) stia su 16 bit.
# 2) se ABS(x)=0 termina, altrimenti
# 3) stampa l'intervallo in cui sono compresi i numeri digitati finora,
#    sempre in modulo e segno.
# 4) ritorna al punto uno
# Esempio:
# ?F
# +00003
# [3 ; 3]
# ?-00005
# [-5 ; 3]
# ?+15305
# [-5 ; 15305]
.INCLUDE "./files/utility.s"

.DATA
x:              .FILL 6, 1, 0
totale_exp:     .WORD 1
totale_somma:   .WORD 0
absX:           .WORD 0
min:            .WORD 0
max:            .WORD 0
sign:           .BYTE 0

.TEXT
_main:
        NOP

input_x:
        LEA x, %ESI
        MOV $6, %CL
        CALL leggi_numero
        MOV $1, %ESI

calcola_abs:
        LEA x, %ESI
        INC %ESI
        MOV $4, %CL             # exp massimo = n-1
        MOV $5, %EDI            # numero di cifre
        MOV $0, %AH
        MOVW $0, totale_somma
        CALL converti_numero
        MOV %AX, absX

check_0:
        CMP $0, %AX
        JE termina

check_empty:
        MOV $0, %ESI
        CMP $0, min
        JE primo
        CMP $0, max
        JE primo

check_sign:
        MOVB x(%ESI), %AL
        CMP $'-', %AL
        JE check_min
        CMP $'+', %AL
        JE check_max

check_max:
        MOV absX, %AX
        MOV max, %DX
        CMP %AX, %DX
        JB sostituisci_max
        JMP stampa_intervallo

sostituisci_max:
        MOV %AX, max
        JMP stampa_intervallo

check_min:
        MOV absX, %AX
        MOV min, %DX
        CMP %AX, %DX
        JB sostituisci_min
        JMP stampa_intervallo

sostituisci_min:
        MOV %AX, min
        JMP stampa_intervallo

stampa_intervallo:
        CALL newline
        MOV $'[', %AL
        CALL outchar
        MOV $'-', %AL
        CALL outchar
        MOV min, %AX
        CALL outdecimal_word
        MOV $',', %AL
        CALL outchar
        MOV $'+', %AL
        CALL outchar
        MOV max, %AX
        CALL outdecimal_word
        MOV $']', %AL
        CALL outchar
        CALL newline
        JMP input_x

primo:
        MOV absX, %AX
        MOV %AX, max
        MOV %AX, min
        MOV x(%ESI), %BL
        MOV %BL, sign
        JMP stampa_primo

stampa_primo:
        CALL newline
        MOV $'[', %AL
        CALL outchar
        MOV sign, %AL
        CALL outchar
        MOV absX, %AX
        CALL outdecimal_word
        MOV $',', %AL
        CALL outchar
        MOV sign, %AL
        CALL outchar
        MOV absX, %AX
        CALL outdecimal_word
        MOV $']', %AL
        CALL outchar
        CALL newline
        JMP input_x

# sottoprogramma che esegue la conversione da stringa a numero in base BX=10 di BX^CL cifre, dentro AX
converti_numero:
        CMP $0, %EDI
        JE salva_numero
        PUSH %ECX
loop_esponente:
        CMP $0, %CL
        JE continua
        MOV totale_exp, %AX
        MOV $10, %BX
        MUL %BX
        MOV %AX, totale_exp
        DEC %CL
        JMP loop_esponente
continua:
        POP %ECX
        MOV $0, %EAX
        MOVB (%ESI), %AL
        MOV totale_exp, %BX
        MUL %BX
        ADD %AX, totale_somma
        DEC %EDI
        INC %ESI
        DEC %CL
        MOVW $1, totale_exp
        JMP converti_numero
salva_numero:
        MOV totale_somma, %AX
        JMP termina

leggi_numero:
check_segno:
        CALL inchar
        CMP $'+', %AL
        JE continua_input
        CMP $'-', %AL
        JE continua_input
        JMP check_segno
continua_input:
        MOVB %AL, (%ESI)
        INC %ESI
        DEC %CL
        CALL outchar
loop_abs:
        CMP $0, %CL
        JE termina
        CALL inchar
        CMP $'0', %AL
        JB loop_abs
        CMP $'9', %AL
        JA loop_abs
        CALL outchar
        AND $0x0F, %AL
        MOV %AL, (%ESI)
        INC %ESI
        DEC %CL
        JMP loop_abs

termina:
        RET
