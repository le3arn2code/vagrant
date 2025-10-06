# Interview Q&A – Lab 05

**Q1:** Why is Netplan preferred on newer Ubuntu versions?
> Netplan provides YAML-based declarative configuration integrated with NetworkManager or systemd-networkd.

**Q2:** What happens if `/etc/network/interfaces` is modified on a Netplan system?
> It has no effect unless the old `ifupdown` system is still active.

**Q3:** Why use `systemctl` checks in Bash scripts?
> To ensure compatibility across different Ubuntu versions and init systems.

**Q4:** What happens if both NetworkManager and Netplan are missing?
> The script gracefully falls back to legacy `ifup/ifdown` commands.
