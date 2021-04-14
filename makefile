CC = gcc

Mprov64: Mprov64.s moduls.s
	@echo "Compiling run file with debugging info"
	${CC} -Wall -no-pie -g Mprov64.s moduls.s -o run
