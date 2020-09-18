    .data
buf:	    .space	64
inbuf:      .space  64
outbuf:     .space  64
buffpos:    .quad   0
inpos:      .quad   0
outpos:     .quad   0

    .text

.global getchar 
.global putText
.global setOutPos
.global getOutPos
.global putInt
.global outImage
.global getInt

inImage:
# Done
    movq $inbuf, %rdi
    movq $64, %rsi
    movq stdin, %rdx
    call fgets
    ret

getInt: 
# Done, NOTE:all numbers are treated as positive ones 
    pushq $0

    # movq $inbuf, %rdi

    xor %rbx, %rbx
    cmpq %rdi, 0
    je inImage

    cmpb $'0', (%rdi) 
    # Check if number is ASCII for number between 0-9
    jl lEnd
    cmpb $'9', (%rdi)
    movzbq (%rdi), %r10 # Mode 
    imulq $10, %rax 
    # Makes nmbr xxxx -> xxxx0
    addq %r10, %rax 
    # adds z to xxxx0 -> xxxxz
    incq %rdi
    
    jmp getInt

    popw %ax

getText: 
    # rsi = max amount of chars to read from inbuf
    # rdi = adress to copy string to
    movq inbuf, %rdx
    call fgets

    ret



stackLoop:

    xor %r10, %r10 # r10 acts as counter

    jmp getChar
    pushq %rax

    add %r10, 1
    cmp %r10, %rsi
    jl stackLoop

    ret


buildLoop:

getChar:
    pushq %r11

    movq $inpos, %r11
    movq (%r11), %rax

    incq %r11

    movq %r11, inpos

    popq %r11 

    ret

getInPos:
    movq $inpos, %rax

    ret

setInPos:  
    movq %rbp, %rsp # saves stack pointer

    pushq %r11

    cmpq %rdi, 64
    jge setMaxPos

    cmpq %rdi, 0
    jle setLowPos

    movq $inbuf, %r11
    movq (%r11), %rdi

    movq %r11, inbuf 

    popq %r11

    ret

setLowPos:
    movq $0, inpos

    ret

setMaxPos:    
    movq $64, inpos

    ret

lEnd:
    ret
