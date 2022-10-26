CC = mpicc

CFLAGS = -g
LDFLAGS = -lm 

all: alltest alltestb alltestm

alltestm: alltestm.o partners.o
	${CC} -o $@ alltestm.o partners.o $(LDFLAGS)

alltestb: alltestb.o partners.o
	${CC} -o $@ alltestb.o partners.o $(LDFLAGS)

alltest: alltest.o partners.o
	${CC} -o $@ alltest.o partners.o $(LDFLAGS)

partners.o: partners.c partners.h

clean:
	rm *.o
	rm -f alltest alltestb


