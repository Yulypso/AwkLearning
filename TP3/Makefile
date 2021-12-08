LIBFLEX	= /usr/local/Cellar/flex/2.6.4_2/lib
CC	?= gcc
RM	= rm -f

.PHONY: all clean check default generate

default:
	@echo "gmake check.flex|check.basic|check.race"

%:%.l
	flex -B -t -F $< > $(basename $<).c
	$(CC) -O3 $(basename $<).c -o $(basename $<) -L$(LIBFLEX) -lfl
	$(RM) -f lex.yy.c

clean:
	$(RM) -f *.core check.flex check.basic check.race
	$(RM) -f *.c
	$(RM) -f zz.output*
	$(RM) -r conf
	$(RM) -r tmp
	mkdir conf
	mkdir tmp

generate: clean
	./generate.sh
