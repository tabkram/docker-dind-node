# Build final docker image now that all binaries are OK
FROM docker:dind as base

ARG NODE_VERSION
ENV NODE_VERSION $NODE_VERSION
ARG FULL_NODE_VERSION
ENV FULL_NODE_VERSION $FULL_NODE_VERSION

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
ENV PATH="/root/node-${FULL_NODE_VERSION}-linux-x64-musl/bin:${PATH}"
RUN echo "export PATH=$PATH" > /etc/environment

# Install Yarn
RUN npm install -g yarn

# Display Node.js and Yarn versions for verification
RUN node -v && yarn -v

# Entrypoint
ENTRYPOINT ["/bin/bash", "-l", "-c"]
CMD ["/bin/sh"]

# Test the image before building
FROM base AS test

RUN node -v && \
    npm -v && \
    yarn -v && \
    uplift version && \
    aws --version

# Create Image after tests
FROM base AS release
