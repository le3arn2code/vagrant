# 🧠 Layman Explanation — How We Did It

We used **Vagrant with Docker** inside our cloud VM (EC2).  
Since cloud VMs can’t run VirtualBox, we used Docker as Vagrant’s backend.  
Here’s what happened:

1. **We created a Vagrant project folder** using:
   ```bash
   mkdir lab01-vagrant-intro && cd lab01-vagrant-intro
   vagrant init
   ```

2. **We edited the file** to use Docker and keep the container running:
   ```ruby
   d.image = "ubuntu:20.04"
   d.cmd = ["tail", "-f", "/dev/null"]
   d.remains_running = true
   ```

3. **We started the container**:
   ```bash
   vagrant up --provider=docker
   ```

4. **We entered the container**:
   ```bash
   docker exec -it <container_name> bash
   ```

5. **We created a simple script** called `system_info.sh` and ran it:
   ```bash
   chmod +x system_info.sh
   ./system_info.sh
   ```

6. **Finally**, we exited and destroyed the container:
   ```bash
   exit
   vagrant destroy -f
   ```

That’s it! 🎉 We learned how to use Vagrant with Docker inside a cloud VM and wrote a small script to explore system info.
