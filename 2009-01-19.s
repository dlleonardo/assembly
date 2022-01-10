# 1) accetta in ingresso un numero naturale X in base 10 con un numero
#    di cifre qualunque da 1 a 100
# 2) se il numero ha una sola cifra, termina, altrimenti
# 3) scrive se il numero X è divisibile per 2, 3, 5, 11
# 4) ritorna al punto 1
# NB: un numero è divisibile per 11 se la somma delle sue cifre,
#     considerate a segni alternati, è divisibile per 11 
# Un numero è divisibile per 2 se e solo se la sua ultima cifra decimale è pari, vale a dire 0, 2, 4, 6, 8.
# Un numero è divisibile per 3 se la somma di tutte le sue cifre è pari a 3 o ad un suo multiplo (6, 9).
# Un numero è divisibile per 5 se la sua ultima cifra è 0 oppure 5
# Un numero è divisibile per 11 se la differenza tra la somma delle sue cifre di posto dispari e la somma delle sue cifre di posto pari dà come 
# risultato 0, 11 o un multiplo (anche intero) di 11. Ad esempio, "8.291.778" è divisibile per 11 perché: (8+7+9+8)-(7+1+2) = 32-10 = 22.
# Es:
# ?123332
# 2: sì
# 3: no
# 5: no
# 11: sì
.INCLUDE "./files/utility.s"

.DATA
numero:             .FILL 80, 1, 0
somma_3:            .WORD 0
somma_11:           .WORD 0

.TEXT
_main:
        NOP

input_X:
        LEA numero, %EBX
        MOV $80, %CX
        CALL inline
        CALL newline

scansione:
        MOV $0, %ESI
        MOV $1, %EDI
        MOV $0, %AH

loop_scan:
        MOVB numero(%EDI), %CL
        CMP $0x0d, %CL
        JE controlla_div
        MOVB numero(%ESI), %AL
        MOV somma_3, %BX
        SUB $'0', %AL
        ADD %AX, %BX                
        MOV %BX, somma_3
        INC %EDI
        INC %ESI
        JMP loop_scan

controlla_div:
        # check div 2
        MOV $0, %EAX
        MOVB numero(%ESI), %AL
        SUB $'0', %AL   

        # concludi la somma delle cifre
        MOV somma_3, %BX
        ADD %AX, %BX
        MOV %BX, somma_3

        MOV $2, %BL
        DIV %BL
        MOV %AH, %DL              # DL = resto
        CALL check_2
        CALL newline

        # check div 3
        MOV somma_3, %AL
        MOV $3, %BL
        DIV %BL
        MOV %AH, %DL
        CALL check_3
        CALL newline

        # check div 5
        MOV $0, %EAX
        MOVB numero(%ESI), %AL
        SUB $'0', %AL             
        MOV $5, %BL
        DIV %BL
        MOV %AH, %DL
        CALL check_5
        CALL newline
        JMP termina

check_5:
        MOV $'5', %AL
        CALL outchar
        MOV $':', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        CMP $0, %DL
        JE stampa_si
        JMP stampa_no

check_3:
        MOV $'3', %AL
        CALL outchar
        MOV $':', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        CMP $0, %DL
        JE stampa_si
        JMP stampa_no

check_2:
        MOV $'2', %AL
        CALL outchar
        MOV $':', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        CMP $0, %DL
        JE stampa_si
        JMP stampa_no

stampa_no:
        MOV $'n', %AL
        CALL outchar
        MOV $'o', %AL
        CALL outchar
        JMP termina

stampa_si:
        MOV $'s', %AL
        CALL outchar
        MOV $'i', %AL
        CALL outchar
        JMP termina

termina:
        RET
