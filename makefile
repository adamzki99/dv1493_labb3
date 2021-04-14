CC = gcc

Mprov64: Mprov64.s moduls.s
    @echo "Compiling a.out file with debugging"
    ${CC} -no-pie -g Mprov64.s moduls.s
