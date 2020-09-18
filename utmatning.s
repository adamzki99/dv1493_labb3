    .data
buf:	    .space	64
inbuf:      .space  64
outbuf:     .space  64
buffpos:    .quad   0
inpos:      .quad   0
outpos:     .quad   0

    .text

    .global inImage                    
    .global getInPos
    .global setInPos
    .global putChar
    .global getint
    .global getText

outImage: 
    pushq $0 
    movq $outbuf, %rdi
    call printf

    xorq %rdi, %rdi
    movq %rdi, outbuf

putInt:
    pushq $0 
    popw %ax

putText:
    

putChar:
    pushq $0 
    popw %ax

getOutPos:
    pushq $0 
    popw %ax

setOutPost:
    pushq $0 
    popw %ax
