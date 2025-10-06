# Lab 08: Building a Custom Software Package with Makefile

## Objective
Use a **Makefile** to automate compile, test, install, and packaging steps for a small C program.

## Prerequisites
- Ubuntu VM (Al Nafi-provided), running
- `sudo` privileges
- Dev tools:
  ```bash
  sudo apt update
  sudo apt install -y build-essential   # gcc, make, libc headers, etc.
  ```

---

## Step-by-Step (nano-friendly)

### 1) Write the C program
```bash
nano hello.c
```
Paste:
```c
#include <stdio.h>

int main() {
    printf("Hello, World! This is my C program.\n");
    return 0;
}
```

### 2) Create the Makefile
> **Important:** Makefile recipe lines must start with a **TAB**, not spaces.

```bash
nano Makefile
```
Paste **with tabs on the indented command lines**:
```
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
```

### 3) Build and run
```bash
make
./hello
# Expected:
# Hello, World! This is my C program.
```

### 4) Test and install via Makefile
```bash
make test
sudo make install
hello
# Expected:
# Hello, World! This is my C program.
```

### 5) Package for distribution
```bash
mkdir -p hello_package
mv hello.c Makefile hello hello_package/
tar -czvf hello_package.tar.gz hello_package/
# On another machine:
#   tar -xzvf hello_package.tar.gz
#   cd hello_package && sudo make install
```

---

## Layman's Summary
We wrote a tiny C app and a **Makefile** that tells the computer how to build, test, and install it. Using simple commands (`make`, `make test`, `sudo make install`) we automated the steps. Finally, we packaged everything into a `.tar.gz` file that others can unpack and install.

---

## Errors We Might Hit & Fixes (Included in troubleshooting.md)
- `make: *** missing separator.  Stop.` → Lines inside rules need **TAB**, not spaces.
- `gcc: command not found` / `make: command not found` → Install `build-essential`.
- `permission denied` on `make install` → Prefix with `sudo`.
- Program not found after install → Ensure `/usr/local/bin` is in `PATH`, or open a new shell.
- Packaging: missing files in tarball → Verify `mv` step and tar command path.

---

## Final Commands (clean path)
```bash
make clean
make
make test
sudo make install
hello
tar -czvf hello_package.tar.gz hello_package/
```


### Screenshot (Proof)
`./screenshots/lab08_make_build_run.png`
