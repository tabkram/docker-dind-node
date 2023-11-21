# Docker [tabkram/dind_node](https://hub.docker.com/r/tabkram/dind_node) 🐳

The Docker image is based on the `docker:dind` image, which stands for **"Docker in Docker."**

This image allows running Docker within a Docker container, which is useful for certain development and testing scenarios.

# Generated image:
This project generates multiple image tags based on node_version See all built Node.js Versions here: **[build.yml](.github%2Fworkflows%2Fbuild.yml)

# Installed Packages:

The Dockerfile installs various Alpine packages to provide essential tools and dependencies within the Docker image. Here's a breakdown of the installed packages:

- **node**:  See all built Node.js Versions here: **[build.yml](.github%2Fworkflows%2Fbuild.yml)
- **yarn**: Yarn is a package manager for JavaScript that efficiently manages project dependencies.
- **aws-cli**: AWS Command Line Interface for interacting with AWS services.
- **curl**: A tool for making HTTP requests.
- **wget**: A utility for downloading files from the internet.
- **zip, tar, gzip**: Utilities for compressing and decompressing files.
- **git**: Version control system for tracking changes in source code.
- **openssl**: Toolkit for working with Transport Layer Security (TLS) and Secure Sockets Layer (SSL) protocols.
- **jq**: Lightweight and flexible command-line JSON processor.
- **bash**: Bourne Again SHell, a widely used command processor.

### Pull the Image

To use this Docker image, pull it from Docker Hub:

```bash
docker pull tabkram/dind_node:<node-version>
```