#!/bin/bash

# Check if the NFS mount is available
echo "Checking if NFS mount is available at /mnt/ncdata..."
if ! mount | grep /mnt/ncdata > /dev/null; then
    echo "Error: /mnt/ncdata is not mounted. Please mount your NFS share."
    exit 1
fi

# Pull the latest Nextcloud AIO image
echo "Pulling latest Nextcloud AIO image..."
docker pull nextcloud/all-in-one:latest

# Start the Nextcloud container
echo "Starting the Nextcloud container..."
sudo docker run \
  --init \
  --sig-proxy=false \
  --name nextcloud-aio-mastercontainer \
  --restart always \
  --publish 80:80 \
  --publish 8080:8080 \
  --env NEXTCLOUD_DATADIR=/mnt/ncdata \
  --env APACHE_PORT=11000 \
  --env APACHE_IP_BINDING=0.0.0.0 \
  --env SKIP_DOMAIN_VALIDATION=true \
  --env PUID=1000 \
  --env PGID=1000 \
  --volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  --volume /mnt/ncdata:/mnt/ncdata \
  nextcloud/all-in-one:latest

echo "Nextcloud AIO setup complete!"
