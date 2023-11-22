#!/bin/sh
set -e

# Start the Docker daemon
dockerd-entrypoint.sh &

# Wait for the Docker daemon to be ready
until docker info >/dev/null 2>&1; do
  echo "Waiting for Docker daemon to start..."
  sleep 1
done

# Display a message indicating that the Docker daemon has started
echo "Docker daemon has started."

# Run the original entrypoint script or command
exec "$@"