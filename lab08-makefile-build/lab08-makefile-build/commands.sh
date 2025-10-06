#!/usr/bin/env bash
# Lab 08 - Commands Script (creates hello.c, Makefile, builds, tests, installs, packages)
set -e

echo "== Install dev tools if needed =="
sudo apt update
sudo apt install -y build-essential

echo "== Create hello.c =="
cat > hello.c <<'EOF_C'
#include <stdio.h>

int main() {
    printf("Hello, World! This is my C program.\n");
    return 0;
}
EOF_C

echo "== Create Makefile (TABs in recipes) =="
cat > Makefile <<'EOF_M'
# Makefile for compiling hello.c

# Compiler and flags
CC = gcc
CFLAGS = -Wall -g

# Output binary name
OUTPUT = hello

# Default target
all: $(OUTPUT)

# Rule to build the program
$(OUTPUT): hello.c
	$(CC) $(CFLAGS) hello.c -o $(OUTPUT)

# Rule to clean the build
clean:
	rm -f $(OUTPUT)

# Rule to install the program
install: $(OUTPUT)
	sudo cp $(OUTPUT) /usr/local/bin/

# Rule to test the program
test: $(OUTPUT)
	./$(OUTPUT)
EOF_M

echo "== Build and test =="
make
./hello

echo "== Run make test =="
make test

echo "== Install globally =="
sudo make install
hello

echo "== Package for distribution =="
mkdir -p hello_package
mv -f hello.c Makefile hello hello_package/
tar -czvf hello_package.tar.gz hello_package/

echo "== Done. Tarball: hello_package.tar.gz =="
