FROM cgr.dev/chainguard/bash:latest as bash
FROM cgr.dev/chainguard/node:latest

USER root

# Copy bash from bash image and create CNB user and directories
COPY --from=bash /usr/bin/bash /bin/bash
RUN addgroup -g 1000 cnb && \
    adduser -u 1000 -G cnb -s /bin/bash -D cnb

RUN mkdir -p /cnb/process /workspace && \
    chown -R cnb:cnb /cnb /workspace

# Set CNB environment variables
ENV CNB_USER_ID=1000
ENV CNB_GROUP_ID=1000
ENV CNB_STACK_ID="chainguard.nodejs"

# Add CNB labels
LABEL io.buildpacks.stack.id="chainguard.nodejs"
LABEL io.buildpacks.stack.description="Chainguard Node.js runtime image for secure application deployment"

USER cnb
WORKDIR /workspace
ENV NODE_ENV=production
ENV PORT=3000
