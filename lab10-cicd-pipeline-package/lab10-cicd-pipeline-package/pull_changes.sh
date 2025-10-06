
#!/bin/bash
set -e
cd /home/toor/deployment_pipeline
echo "Pulling the latest changes from GitHub..."
git pull origin main
echo "Changes pulled successfully!"
