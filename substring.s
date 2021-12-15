# Read a string from terminal, that must contains at least 2 '_' characters
# Identify and print the substring between the first 2 '_' characters

.INCLUDE "./files/utility.s"

.DATA
msg_in:     .FILL 80, 1, 0

.TEXT
_main:
        NOP
        MOV $80, %ECX
        LEA msg_in, %EBX
        CALL inline
        LEA msg_in, %EDI
        MOV $'_', %AL
        CLD

check_str:
        REPNE SCASB
        MOV %EDI, %EBX
        REPNE SCASB
        MOV %EDI, %ECX
        SUB %EBX, %ECX
        DEC %ECX

print:
        CALL outmess
        RET
