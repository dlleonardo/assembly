.INCLUDE "./files/utility.s"

.DATA
array:      .FILL 10, 1
aux:        .FILL 10, 1

.TEXT
_main:
        NOP
        MOV $10, %CL
        LEA array, %ESI
        LEA aux, %EDI
        CALL leggi_cifre

comando:
        CALL newline
        CALL inchar
        CMP $'s', %AL
        JE ruota_sx
        CMP $'d', %AL
        JE ruota_dx
        CMP $'r', %AL
        JE inverti
        CMP $'q', %AL
        JE termina
        JMP comando

ruota_sx:
        MOV $9, %ESI
        MOV $8, %EDI

loop_sx:
        CMP $0, %ESI
        JE fine_loop_sx
        MOVB aux(%ESI), %AL
        MOVB %AL, array(%EDI)
        DEC %ESI
        DEC %EDI
        JMP loop_sx

fine_loop_sx:
        MOV $9, %EDI
        MOVB aux(%ESI), %AL
        MOVB %AL, array(%EDI)
        JMP sovrascrivi_aux
        
ruota_dx:
        MOV $0, %ESI
        MOV $1, %EDI

loop_ruota_dx:
        CMP $9, %ESI
        JE fine_loop_dx
        MOVB aux(%ESI), %AL
        MOVB %AL, array(%EDI)
        INC %ESI
        INC %EDI
        JMP loop_ruota_dx

fine_loop_dx:
        MOV $9, %ESI
        MOV $0, %EDI
        MOVB aux(%ESI), %AL
        MOVB %AL, array(%EDI)
        JMP sovrascrivi_aux

inverti:
        MOV $0, %ESI
        MOV $9, %EDI

loop_inverti:
        CMP $10, %ESI
        JE sovrascrivi_aux
        MOVB aux(%ESI), %AL
        MOVB %AL, array(%EDI)
        INC %ESI
        DEC %EDI
        JMP loop_inverti

sovrascrivi_aux:
        MOV $0, %ESI      

loop_sovrascrivi_aux:
        CMP $10, %ESI
        JE stampa
        MOVB array(%ESI), %AL
        MOVB %AL, aux(%ESI)
        INC %ESI
        JMP loop_sovrascrivi_aux

stampa:
        CALL newline
        MOV $0, %ESI
        
loop_stampa:
        CMP $10, %ESI
        JE comando
        MOVB array(%ESI), %AL
        CALL outdecimal_byte
        INC %ESI
        JMP loop_stampa

leggi_cifre:
        CMP $0, %CL
        JE comando
        CALL inchar 
        CMP $'0', %AL
        JB leggi_cifre
        CMP $'9', %AL
        JA leggi_cifre
        CALL outchar
        AND $0x0F, %AL
        MOVB %AL, (%ESI)
        MOVB %AL, (%EDI)
        INC %ESI
        INC %EDI
        DEC %CL
        JMP leggi_cifre

termina:
        RET
