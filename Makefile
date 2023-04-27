# Hamiltonian cycle
# FLP LOG 2022/2023
# Autor: Martin Jacko (222092) <xjacko05@stud.fit.vutbr.cz>
# Contents: Makefie

.PHONY: clean test zip all

all:
	@swipl -q --goal=main --stand_alone=true -o flp22-log -c main.pl

test: all
	@./test.sh

clean:
	@rm ./flp22-log ./tests/*.real

zip:
	zip -r flp-log-xjacko05.zip main.pl Makefile test.sh README.md tests