# Interview Q&A (10 real-life)

1. **What problem does a Makefile solve?**  
   It encodes build steps and dependencies so you can reproduce builds reliably (`make`, `make test`, `make install`).

2. **Why do recipe lines need TABs?**  
   It’s historical GNU make syntax; commands in a rule must start with a TAB, not spaces.

3. **What does `CFLAGS = -Wall -g` do?**  
   `-Wall` enables common warnings; `-g` includes debug symbols for tools like `gdb`.

4. **How does `make` decide what to rebuild?**  
   It compares timestamps of targets versus prerequisites; rebuilds only when needed.

5. **What does `make clean` typically do?**  
   Removes build artifacts (binaries, objects) so you can rebuild from a clean state.

6. **Why install to `/usr/local/bin`?**  
   It’s a standard path for locally installed user programs without overwriting distro-managed files.

7. **How would you add unit tests?**  
   Add a `test` target that runs test binaries or scripts; integrate with `ctest` or simple shell assertions.

8. **How do you add multiple source files?**  
   Add them to the build rule or compile separately to `.o` files and link: `$(CC) $(CFLAGS) file1.c file2.c -o app`.

9. **How can you see the exact commands `make` runs?**  
   Run `make V=1` or prefix with `@`/remove to toggle echoing; or use `make -n` for a dry-run.

10. **How would you package for Debian?**  
    Use `dpkg-deb`/`debhelper` to create a `.deb`; for this lab we used a tarball for simplicity.
