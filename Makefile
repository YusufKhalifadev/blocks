PREFIX  := /usr/local
CC      := cc
OPTIMISATIONS = -march=native -mtune=native -flto=auto -O3
CFLAGS  := ${OPTIMISATIONS} -pedantic -Wall -Wno-deprecated-declarations -Os
LDFLAGS := -lX11

# FreeBSD (uncomment)
#LDFLAGS += -L/usr/local/lib -I/usr/local/include
# # OpenBSD (uncomment)
#LDFLAGS += -L/usr/X11R6/lib -I/usr/X11R6/include

all: options blocks

options:
	@echo blocks build options:
	@echo "CFLAGS  = ${CFLAGS}"
	@echo "LDFLAGS = ${LDFLAGS}"
	@echo "CC      = ${CC}"

blocks: blocks.c blocks.h
	${CC} -o blocks blocks.c ${CFLAGS} ${LDFLAGS}

blocks.h:
	cp blocks.h $@

clean:
	rm -f *.o *.gch blocks

install: blocks
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f blocks ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/blocks

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/blocks

.PHONY: all options clean install uninstall
