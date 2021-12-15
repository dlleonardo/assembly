# Read a string from terminal
# Identify and print the substring between the first 2 '_' characters
# If only there's only one '_' character, print the string from the start to the '_' character
# If there isn't any '_' character, print all the string

.INCLUDE "./files/utility.s"

.DATA
msg_in:     .FILL 80, 1, 0

.TEXT
_main:
        NOP
        MOV $80, %ECX
        LEA msg_in, %EBX
        CALL inline
        MOV $'_', %AL 
        LEA msg_in, %EDI
        CLD

check_str:
        REPNE SCASB
        CMP $0, %ECX
        JE print_all
        MOV %EDI, %ESI
        REPNE SCASB
        CMP $0, %ECX
        JE print_first_part
        
print_substr:
        MOV %EDI, %ECX
        MOV %ESI, %EBX
        SUB %EBX, %ECX
        DEC %ECX
        CALL outmess
        RET

print_first_part:
        LEA msg_in, %EBX
        SUB %EBX, %ESI
        MOV %ESI, %ECX
        DEC %ECX
        CALL outmess
        RET

print_all:
        LEA msg_in, %EBX
        CALL outline
        RET
