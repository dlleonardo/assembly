# 1) legge con eco da tastiera (effettuando gli opportuni controlli)
#   due numeri naturali A e B in base 10, di 4 cifre 
# 2) se A>=B termina, altrimenti: 
# 3) legge con eco da tastiera (effettuando gli opportuni controlli)
#    un numero naturale N di due cifre
# 4) stampa a video, su una nuova riga la sequenza di N numeri: 
#    B+(B-A), B+2*(B-A), ... , B+N*(B-A)
#    eventualmente terminando la sequenza in anticipo qualora il
#    successivo numero da stampare non appartenga all'intervallo 
#    di rappresentabilita' per numeri naturali su 16 bit
# 5) ritorna al punto 1).
# Esempio:
# 0013
# 0025
# 05
# 37 49 61 73 85
#
# 0000
# 9000
# 12
# 18000 27000 36000 45000 54000 63000
.INCLUDE "./files/utility.s"

.DATA
A:              .FILL 4, 1, 0
B:              .FILL 4, 1, 0
N:              .FILL 2, 1, 0
totale_exp:     .WORD 1
totale_somma:   .WORD 0
numA:           .WORD 0
numB:           .WORD 0
numN:           .WORD 0

.TEXT
_main:
        NOP

input_A:
        LEA A, %ESI
        MOV $4, %CL
        CALL leggi_numero
        CALL newline

input_B:
        LEA B, %ESI
        MOV $4, %CL
        CALL leggi_numero
        CALL newline

converti_A:
        LEA A, %ESI
        # devo moltiplicare 10^3*n3 + 10^2*n2 + ... + 10^0*n0
        MOV $3, %CL     # lo uso come esponente 10^CL
        MOV $4, %EDI    # lo uso come indice, quando == 0 mi fermo
        MOV $0, %AH
        CALL converti_numero
        MOV %AX, numA

converti_B:
        LEA B, %ESI
        MOV $3, %CL     
        MOV $4, %EDI    
        MOV $0, %AH
        MOVW $0, totale_somma
        CALL converti_numero
        MOV %AX, numB

check_A_B:
        MOV numB, %BX
        MOV numA, %AX
        CMP %BX, %AX
        JAE termina

input_N:
        LEA N, %ESI
        MOV $2, %CL
        CALL leggi_numero
        CALL newline

converti_N:
        LEA N, %ESI
        MOV $1, %CL     
        MOV $2, %EDI    
        MOV $0, %AH
        MOVW $0, totale_somma
        CALL converti_numero
        MOV %AX, numN

stampa:
        # B+(B-A), B+2*(B-A), ... , B+N*(B-A)
        MOV numA, %AX
        MOV numB, %BX
        MOV $1, %CL
        SUB %AX, %BX    # BX contiene coefficiente (B-A)

loop_stampa:
        CMP numN, %CL
        JA termina
        MOV $0, %DX
        MOV $0, %AH
        MOV %CL, %AL
        MUL %BX
        PUSH %EBX
        MOV numB, %BX
        ADD %BX, %AX
        POP %EBX
        CALL outdecimal_word
        MOV $' ', %AL
        CALL outchar
        INC %CL
        JMP loop_stampa

# sottoprogramma che esegue la conversione da stringa a numero in base 10 di CL cifre
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

# sottoprogramma per la lettura di cifre
leggi_numero:
        CMP $0, %CL
        JE termina
        CALL inchar
        CMP $'0', %AL
        JB leggi_numero
        CMP $'9', %AL
        JA leggi_numero
        CALL outchar
        AND $0x0F, %AL
        MOVB %AL, (%ESI)
        INC %ESI
        DEC %CL
        JMP leggi_numero

termina:
        RET
