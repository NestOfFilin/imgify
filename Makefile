# cut is necessary for Cygwin
PLATFORM_OS := $(shell uname | cut -d_ -f1)

all: bin2png png2bin

clean:
	@rm -rf *.o bin2png png2bin

CFLAGS = $(CFLAGS) -D_XOPEN_SOURCE=600 -std=c99 -Wall -Wextra
LDFLAGS = -lpng

ifeq ($(PLATFORM_OS), Linux)
	LDFLAGS += -lm # required for sqrt()
endif

common.o: common.h
	echo $(PLATFORM_OS)
	gcc -o $@ -c common.c $(CFLAGS)

imgify.o: imgify.h
	gcc -o $@ -c imgify.c $(CFLAGS)

bin2png: common.o imgify.o
	gcc -o $@ bin2png.c $^ $(CFLAGS) $(LDFLAGS)

png2bin: common.o imgify.o
	gcc -o $@ png2bin.c $^ $(CFLAGS) $(LDFLAGS)
