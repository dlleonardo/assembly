# Read a only letters message from terminal 
# Convert to lowercase, using only string instructions
# Print the message

.INCLUDE "./files/utility.s"

.DATA
msg_in:     .FILL 80, 1, 0
msg_out:    .FILL 80, 1, 0

.TEXT
_main:  
        NOP
        MOV $80, %CX
        LEA msg_in, %EBX
        CALL inline         # routine inside 'utility.s' file, uses %EBX as buffer and %CX as max number (80) of characters
        CLD
        LEA msg_in, %ESI
        LEA msg_out, %EDI

loop:
        CMP $0x0d, %AL
        JE end
        LODSB
        CMP $'A', %AL
        JB continue
        CMP $'Z', %AL
        JA continue
        OR $0x20, %AL       # set bit number 5, 2 = 0010, 0 = 0000

continue:
        STOSB
        JMP loop

end:
        LEA msg_out, %EBX
        CALL outline
        RET
