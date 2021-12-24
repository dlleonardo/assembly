#Scrivere un programma che esegue ciclicamente le seguenti azioni:
#
#1) legge con eco da tastiera una stringa di caratteri terminata da un ritorno carrello;
#2) sostituisce tutte le vocali nella stringa con il carattere #;
#3) per ciascuna vocale, stampa il numero di vocali rimosse dalla stringa;
#4) stampa la stringa senza vocali.
#
#Il programma termina quando viene inserita la stringa STOP.
#Esempio.
#
#Prova pratica di reti logiche
#a 3
#e 2
#i 4
#o 2
#u 0
#Pr#v# pr#t#c# d# r#t# l#g#ch#

.INCLUDE "./files/utility.s"

.DATA
msg_in:     .FILL 80, 1, 0
vocali:     .FILL 5, 1, 0

.TEXT
_main:
        NOP
        MOV $80, %CX
        LEA msg_in, %EBX
        CALL inline
        MOV $0, %EAX
        MOV $0, %EDX
        LEA msg_in, %EBX

conta:
        MOV (%EBX), %AL
        CMP $0x0d, %AL
        JE stampa
        CMP $'a', %AL
        JE vocale_a
        CMP $'e', %AL
        JE vocale_e
        CMP $'i', %AL
        JE vocale_i
        CMP $'o', %AL
        JE vocale_o
        CMP $'u', %AL
        JE vocale_u
        INC %EBX
        JMP conta

vocale_a:
        SUB $'a', %AL
        INCB vocali(%EAX)
        INC %EBX
        JMP conta

vocale_e:
        SUB $'d', %AL
        INCB vocali(%EAX)
        INC %EBX
        JMP conta

vocale_i:
        SUB $'g', %AL
        INCB vocali(%EAX)
        INC %EBX
        JMP conta

vocale_o:
        SUB $'l', %AL
        INCB vocali(%EAX)
        INC %EBX
        JMP conta

vocale_u:
        SUB $'q', %AL
        INCB vocali(%EAX)
        INC %EBX
        JMP conta

stampa:
        MOV $0, %EDX
        MOV $0, %EAX

        MOV $'a', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOVB vocali(%EDX), %AL
        ADD $'0', %AL
        CALL outchar
        CALL newline
        INC %EDX

        MOV $'e', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOVB vocali(%EDX), %AL
        ADD $'0', %AL
        CALL outchar
        CALL newline
        INC %EDX

        MOV $'i', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOVB vocali(%EDX), %AL
        ADD $'0', %AL
        CALL outchar
        CALL newline
        INC %EDX

        MOV $'o', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOVB vocali(%EDX), %AL
        ADD $'0', %AL
        CALL outchar
        CALL newline
        INC %EDX

        MOV $'u', %AL
        CALL outchar
        MOV $' ', %AL
        CALL outchar
        MOVB vocali(%EDX), %AL
        ADD $'0', %AL
        CALL outchar
        CALL newline

print_riga:
        LEA msg_in, %EBX

loop_print_riga:
        MOVB (%EBX), %AL
        CMP $0x0d, %AL
        JE fine
        CMP $'a', %AL
        JE print_simbolo
        CMP $'e', %AL
        JE print_simbolo
        CMP $'i', %AL
        JE print_simbolo
        CMP $'o', %AL
        JE print_simbolo
        CMP $'u', %AL
        JE print_simbolo
        CALL outchar
        INC %EBX
        JMP loop_print_riga

print_simbolo:
        MOV $'#', %AL
        CALL outchar
        INC %EBX
        JMP loop_print_riga

fine:
        RET
