# Nextcloud AIO Setup with NFS

This repository contains the configuration and setup files for deploying [Nextcloud All-in-One (AIO)](https://github.com/nextcloud/all-in-one) with NFS as the data directory.

## Prerequisites
- Docker installed on your server
- NFS server mounted on the host (e.g., `/mnt/ncdata`)
- Access to a reverse proxy or Caddy configuration (optional)

## Steps to Setup
1. Clone the repository to your host.
2. Adjust the `docker run` command in the `setup.sh` script to reflect your setup (e.g., set `PUID`, `PGID`, and `NEXTCLOUD_DATADIR`).
3. Run the `setup.sh` script to start the container.

### Running the Setup

Run the following commands:

```bash
git clone https://github.com/your-username/nextcloud-aio-setup.git
cd nextcloud-aio-setup
chmod +x scripts/setup.sh
./scripts/setup.sh
