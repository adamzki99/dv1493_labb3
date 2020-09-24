    .data
endOfText:   .asciz  "\0"
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
.global inImage                    
.global getInPos
.global setInPos
.global putChar
.global getint
.global getText

# ------------------ INMATNING ------------------

inImage:
# Done
    movq    $inpos, 0  # Nollställ inpos
    movq    $inbuf, %rdi        
    movq    $5,%rsi             
    movq    stdin, %rdx         
    call    fgets

getInt: 
    # Rutinen ska tolka en sträng som börjar på aktuell buffertposition i inbufferten och fortsättatills ett tecken som inte kan ingå i ett heltal påträffas. 
    # Den lästa substrängen översätts tillheltalsformat och returneras. 
    # Positionen i bufferten ska vara det första tecken som inteingick i det lästa talet när rutinen lämnas. 
    # Inledande blanktecken i talet ska vara tillåtna.

    ret

getText: 

    ret

getChar:
   

    ret

getInPos:

    ret

setInPos:  
    
    ret

setLowPos:

    ret

setMaxPos:    

    ret

# ------------------ UTMATNING ------------------
    

outImage: 
    
    movq $outbuf, %rdi
    call printf

    xorq %rdi, %rdi
    movq %rdi, outbuf

    ret

putInt:
    
    ret

putText:

    # Rutinen ska lägga textsträngen som finns i buf från och med den aktuella positionen i utbufferten. 
    # Glöm inte att uppdatera utbuffertens aktuella position innan rutinen lämnas.
    # Om bufferten blir full så ska ett anrop till outImage göras, så att man får en tömd utbuffertatt jobba vidare mot.
    # Parameter %rdi: adress som strängen ska hämtas till utbufferten ifrån (buf i texten)
    pushq %rdi

    movq $inbuf,%r11
    movq (%rdi), %r10

putTextLoop:
    movq %r10, (%r11) 

    incq %rdi
    incq %r11

    movq (%rdi), %r10

    cmpq 0xFF, %r10
    jne putTextLoop

    popq %rdi
    ret

putChar:

    ret

getOutPos:

    ret

setOutPos:

    ret
