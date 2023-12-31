# Use the official Docker image with Docker in Docker support
FROM docker:dind as base

ARG NODE_VERSION
ENV NODE_VERSION $NODE_VERSION
ARG FULL_NODE_VERSION
ENV FULL_NODE_VERSION $FULL_NODE_VERSION

# Create a directory for Docker entrypoint scripts
RUN mkdir -p /docker-entrypoint.d

# Create a Docker entrypoint script
COPY entrypoint.sh /docker-entrypoint.d/entrypoint.sh
RUN chmod +x /docker-entrypoint.d/entrypoint.sh

# Install alpine packages
RUN apk update
RUN apk upgrade --available
RUN apk add --no-cache aws-cli curl wget zip tar gzip git openssl jq bash
RUN rm -rf /var/cache/apk/*

# Test AWSCLI
RUN aws --version

# Install nodejs for musl linux
COPY files/node-linux-x64-musl.tar.gz /root/node-linux-x64-musl.tar.gz
RUN tar -xvzf /root/node-linux-x64-musl.tar.gz -C /root
RUN rm /root/node-linux-x64-musl.tar.gz

RUN ln -s /root/node-${FULL_NODE_VERSION}-linux-x64-musl/bin/node /usr/local/bin/node
RUN ln -s /root/node-${FULL_NODE_VERSION}-linux-x64-musl/bin/npm /usr/local/bin/npm
RUN ln -s /root/node-${FULL_NODE_VERSION}-linux-x64-musl/bin/npx /usr/local/bin/npx

# Install Yarn
RUN npm install -g yarn

RUN ln -s /root/node-${FULL_NODE_VERSION}-linux-x64-musl/bin/yarn /usr/local/bin/yarn
RUN ln -s /root/node-${FULL_NODE_VERSION}-linux-x64-musl/bin/yarnpkg /usr/local/bin/yarnpkg

# Display Node.js and Yarn versions for verification
RUN node -v && yarn -v

# Set the Docker entrypoint
ENTRYPOINT ["/docker-entrypoint.d/entrypoint.sh"]

# Test the image before building
FROM base AS test

RUN node -v && \
    npm -v && \
    yarn -v && \
    uplift version && \
    aws --version

# Create Image after tests
FROM base AS release
