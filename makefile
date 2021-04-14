CC = gcc

Mprov64: Mprov64.s moduls.s
	@echo "Compiling run file with debugging info"
	${CC} -g -O2 -pipe -Wall -no-pie Mprov64.s moduls.s -o run
