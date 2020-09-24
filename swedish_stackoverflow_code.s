# https://stackoverflow.com/questions/32397984/assembly-att-assignment-puts-buffer-stack

#include <stdio.h>          #Inkludera standard I/O

.data                   #Specifiera data
inbuff:         .space  64  #Inbuffert, reserverar 64 bytes i minnet (.space går att använda liknande som .skip)
utbuff:         .space  64  #Utbuffert, 64 bytes i minnet
buff:           .space  64  #Buffert, Samma
buffpos:        .quad   0   #Lagrar 64 bitar (.quad liknande .long fast 64 resp 32 bitar)
inpos:          .quad   0
utpos:          .quad   0
Slut:           .asciz  "slut\n"

.text                   #Innehåller programkod

.global inImage             #Gör funktionerna globala
.global getchar             #så att de kan anropas i Mprov
.global getInPos
.global setInPos
.global putChar
.global putText
.global getint
.global setOutPos
.global getOutPos
.global putInt
.global outImage
.global getText
.global getInt


Clearbuffer:
#movq   $buff,%eax
#movq   $0,%ebx

inImage:                
                    #läser in en ny textrad från tangentbordet till er inläsningsbuffert för indata och nollställer
                    #positionen till den aktuella bufferten. Andra inläsningsrutiner kommer sedan att jobba mot den här
                    #bufferten. Om positionen står vid buffertens slut när någon av de andra inläsningsrutinerna nedan
                    #anropas ska inimage anropas automatiskt (i den aktuella rutinen), så att det alltid finns data att
                    #arbeta med.
# movq   $inpos, $0          #Nollställ inpos
movq    $inbuff, %rdi           #Lägg i inbuff, där inbuff är en bit reserverat minne(register destination index)
movq    $5,%rsi             #Högst 5-1=4 tecken (NULL räknas ju också)(rsi=register source index)
movq    stdin, %rdx         #Från standard input stdin=$0 om ej def.(rax/rdx= return value)
call    fgets

getInt:                 #Returnerar ett heltal, tolkar en sträng som omvandlas till en int när positionen i bufferten
                    #påträffas(ett tecken som inte kan ingå i ett heltal.)  

getText:                #Överför n tecken från aktuell position, returnera antalet verkligt överförda tecken

getChar:                # Returnerar ett tecken och flyttar fram aktuell position ett steg

getInPos:               # Returnera aktuell buffertposition för inbufferten

setInPos:               # Sätt aktuell buffertposition för inbufferten till n. n måste dock ligga i intervallet [0,MAXPOS].
                    # Om n<0 sätt den till 0, om n>MAXPOS sätts den till MAXPOS.

outImage:               #Skriv ut strängen i utbufferten i terminalen. Om någon av nedanstående utdatarutiner når 
                    #buffertens slut så ska ett anrop till outimage göras automatiskt så att man får en tömd
                    #utbuffert att jobba mot.                   
movq    $utbuff, stdout 
call    puts

putInt:                 #lägg ut talet n som sträng i utbufferten från och med den aktuella positionen. 
                    #Glöm inte att uppdatera aktuell position.

putText:                #Lägg texten som finns i buf från och med den aktuella positionen i utbufferten.

#subq   $8, utbuff          #lägg in buf i utbufferten
popq    utbuff
call puts
ret
#movq   %rdi, utbuff
#addq   $1,$utpos           # Uppdatera aktuell position i utbuff

putChar:                #Lägg tecknet c i utbufferten och flytta fram aktuell position ett steg.
#rensa stackarna

#movb   8(%rbp), %bl            #Lägg in en 8 bitar i rbp lower
#movq   $utbuff,%rcx            #
#movq   $utpos,%rax         #uppdatera position(+1)(Inc)
getOutPos:              #Returnera aktuell buffertposition för utbufferten

setOutPos:              #Sätt aktuell buffertposition för utbufferten till n. 
                    #n måste dock ligga i intervallet[0,MAXPOS]. Om n<0 sätt den till 0, om n>MAXPOS sätts den till MAXPOS.