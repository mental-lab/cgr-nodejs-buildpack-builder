FROM cgr.dev/chainguard/wolfi-base:latest

# Install Node.js and npm
RUN apk add --no-cache \
    nodejs \
    npm \
    git \
    ca-certificates

# Create CNB user and directories
RUN addgroup -g 1000 cnb && \
    adduser -u 1000 -G cnb -s /bin/sh -D cnb

RUN mkdir -p /cnb/buildpacks /cnb/platform /layers /workspace && \
    chown -R cnb:cnb /cnb /layers /workspace

# Set CNB environment variables
ENV CNB_USER_ID=1000
ENV CNB_GROUP_ID=1000
ENV CNB_STACK_ID="chainguard.nodejs"

# Add CNB labels
LABEL io.buildpacks.stack.id="chainguard.nodejs"
LABEL io.buildpacks.stack.description="Chainguard Wolfi-based build image for Node.js applications"

USER cnb
WORKDIR /workspace
