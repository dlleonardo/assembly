# ===========================================================
# Scrivere un programma Assembler che si comporta come segue:
# 1. richiede in ingresso un numero decimale X, assumendo che stia su
#    16 bit.
# 2. Se X=0 termina, altrimenti
# 3. Stampa X in base 4 e ritorna al punto 1
#
# Es: 
# ?48
# 300
#
# ?65535
# 33333333
# ===========================================================
.INCLUDE "./files/utility.s"

.DATA
risultato:      .FILL 8, 2

.TEXT
_main:
        NOP

input_X:
        # %AX contiene il numero appena inserito
        CALL indecimal_word

check_0:
        CMP $0, %AX
        JE termina

converti:
        MOV $0, %ECX
        MOV $0, %ESI
        MOV $0, %DX
        MOV $4, %BX
        
loop_converti:
        DIV %BX
        MOVW %DX, risultato(%ESI)
        MOV $0, %DX
        INC %ESI
        CMP $0, %AX
        JE stampa
        JMP loop_converti

stampa:
        CALL newline

loop_stampa:
        CMP $0, %ESI
        JE termina
        DEC %ESI
        MOVB risultato(%ESI), %AL
        CALL outdecimal_byte
        JMP loop_stampa

termina:
        RET
