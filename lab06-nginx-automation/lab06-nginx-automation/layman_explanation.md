# Layman's Explanation

Think of your server like a shop. **Nginx** is the shop front that greets visitors. We installed Nginx (the shop front), placed a simple **index.html** sign in the window so visitors see a message, and then wrote a **script** that can set the shop up automatically anytime—so you don’t have to repeat the manual steps. If the door (port 80) is blocked by a guard (firewall) or someone else is using the doorway (another web server), we open the door and ask the other person to move. Finally, we checked that visitors can see the sign using a browser or the `curl` tool.
