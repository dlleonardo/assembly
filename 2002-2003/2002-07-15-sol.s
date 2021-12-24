#Scrivere un programma che si comporta come segue:
#1. legge con eco da tastiera le rappresentazioni A di un intero a, e B
#   di un intero b, in complemento alla radice su 2 cifre in base dieci.
#   Il programma deve fare i necessari controlli in modo da accettare
#   SOLTANTO le codifiche ASCII di ESATTAMENTE 2 cifre decimali;
#2. se l'intero c = a + b è rappresentabile in complemento alla radice
#   su 2 cifre in base dieci, stampa, su una riga separata, la rappre-
#   sentazione C di c, e ritorna al passo 1. Altrimenti, termina.
#Esempio:
#Immettere la rappresentazione di a:
#74
#Immettere la rappresentazione di b:
#90
#La rappresentazione di a+b e':
#64

.INCLUDE "./files/utility.s"

.DATA
A:    .BYTE 0
B:    .BYTE 0
a:    .BYTE 0
b:    .BYTE 0

.TEXT
_main:
        NOP
        MOV $0, %EAX
        MOV $0, %EBX

input_A:
        CALL indecimal_byte
        CMP $99, %AL
        JA fine
        MOV %AL, A
        CALL newline
        
input_B:
        CALL indecimal_byte
        CMP $99, %AL
        JA fine
        MOV %AL, B
        CALL newline

calcola_a:
        MOV A, %AL
        CMP $50, %AL
        JAE complementa_A
        JMP calcola_b

complementa_A:
        MOV $100, %CL
        SUB %AL, %CL
        NEG %CL
        MOV %CL, %AL

calcola_b:
        MOV %AL, a
        MOV B, %BL
        CMP $50, %BL
        JAE complementa_B
        MOV %BL, b
        JMP somma

complementa_B:
        MOV $100, %CL
        SUB %BL, %CL
        NEG %CL
        MOV %CL, b

somma:
        MOV a, %AL
        MOV b, %BL
        ADD %BL, %AL
        CMP $0, %AL
        JL stampa_100
        CALL outdecimal_byte
        JMP fine

stampa_100:
        ADD $100, %AL
        CALL outdecimal_byte

fine:
        RET
