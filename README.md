# Nextcloud AIO Setup with NFS and Cloudflare tunnel

This repository contains the configuration and setup files for deploying [Nextcloud All-in-One (AIO)](https://github.com/nextcloud/all-in-one) with NFS as the data directory.

## Prerequisites
- Docker installed on your server - See [Docker Installation](https://docs.docker.com/engine/install/#supported-platforms)
- NFS server mounted on the host (e.g., `/mnt/ncdata`)
- Access to a reverse proxy or Caddy configuration (optional) - See [Reverse Proxy](https://github.com/nextcloud/all-in-one/blob/main/reverse-proxy.md)

## Steps to Setup
1. Clone the repository to your host.
2. Adjust the `docker run` command in the `setup.sh` script to reflect your setup (e.g., set `PUID`, `PGID`, and `NEXTCLOUD_DATADIR`).
3. Run the `setup.sh` script to start the container.

### Running the Setup

Run the following commands to start the setup:

```bash
git clone https://github.com/nicolasnkGH/nextcloud-aio-setup
cd nextcloud-aio-setup
chmod +x scripts/setup.sh
./scripts/setup.sh
```

## Manual Setup

If you prefer to manually set up the container, follow the steps below.

### Steps to Manually Run Nextcloud AIO with Docker

1.  Make sure Docker is installed on your host.
2.  Set the following environment variables in your terminal or script (adjust `PUID`, `PGID`, and `NEXTCLOUD_DATADIR` to your preferences):

    ```bash
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
    --env PUID=1000 \  # Replace with your PUID
    --env PGID=1000 \  # Replace with your PGID
    --volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --volume /mnt/ncdata:/mnt/ncdata \
    nextcloud/all-in-one:latest
    ```

    * This will run the Nextcloud AIO container with your NFS mount as the data directory.
    * Make sure that `/mnt/ncdata` is the correct mount point for your NFS server.

3.  Access Nextcloud via your browser at `http://<your-server-ip>:8080` to complete the setup.

### System Configuration

This setup was tested on the following system:

* Server: Proxmox (running in a virtual machine)
* VM Resources:
    * 4 CPU cores
    * 12GB of RAM

**Note:** I allocated 12GB of RAM because I encountered issues with containers crashing during installation with lower memory settings. Increasing the memory helped ensure a smooth setup.

## General Tips

- Always check the [Nextcloud AIO GitHub repository](https://github.com/nextcloud/all-in-one) for known issues and updates.

- When in doubt, inspect the logs of the container for further troubleshooting:

    ```bash
    docker logs nextcloud-aio-mastercontainer
    ```

- If none of the above solutions work for your case, feel free to open an issue in the repository or ask for help on relevant forums or community channels.
