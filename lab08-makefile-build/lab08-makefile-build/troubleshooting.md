# Troubleshooting

## 1) `make: *** missing separator.  Stop.`
**Cause:** Makefile recipe lines must start with a **TAB**, not spaces.  
**Fix:** Replace leading spaces before commands with an actual tab.

## 2) `gcc: command not found` or `make: command not found`
**Cause:** Build tools are missing.  
**Fix:** `sudo apt install -y build-essential`

## 3) Permission error on `make install`
**Cause:** Installing to a system directory requires root privileges.  
**Fix:** Use `sudo make install`

## 4) `hello: command not found` after install
**Cause:** Shell `PATH` does not yet include `/usr/local/bin` or you need a new session.  
**Fix:** `echo $PATH` to confirm; open a new terminal or `hash -r`. Alternatively, run `/usr/local/bin/hello`.

## 5) Tarball doesn’t contain expected files
**Cause:** Wrong working directory or paths in `mv`/`tar`.  
**Fix:** Verify with `ls -R hello_package` before `tar -czvf ...`

## 6) Rebuild from scratch
```bash
make clean
make
make test
sudo make install
```
