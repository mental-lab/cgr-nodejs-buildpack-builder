FROM cgr.dev/chainguard/wolfi-base:latest

RUN apk add --no-cache \
    nodejs \
    bash

RUN addgroup -g 1000 cnb && \
    adduser -u 1000 -G cnb -s /bin/bash -D cnb

RUN mkdir -p /cnb/process /workspace && \
    chown -R cnb:cnb /cnb /workspace

ENV CNB_USER_ID=1000
ENV CNB_GROUP_ID=1000
ENV CNB_STACK_ID="chainguard.nodejs"

LABEL io.buildpacks.stack.id="chainguard.nodejs"
LABEL io.buildpacks.stack.description="Chainguard Wolfi-based runtime image for Node.js applications"

USER cnb
WORKDIR /workspace
ENV NODE_ENV=production
ENV PORT=3000
