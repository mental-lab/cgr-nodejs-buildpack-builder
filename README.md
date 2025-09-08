# Chainguard Node.js Buildpack

Secure Cloud Native Buildpack for Node.js apps using Chainguard's distroless images.

## Quick Start

```bash
# Build your Node.js app
pack build my-app --builder ghcr.io/mental-lab/chainguard-node-builder:latest

# Run your app
docker run --rm -p 3000:3000 my-app
```

## Requirements

- [Pack CLI](https://buildpacks.io/docs/tools/pack/)
- Docker
- Node.js project with `package.json`

## What You Get

- **Fixed Node.js Version** - Uses latest Node.js from Chainguard
- **Secure Base Images** - Chainguard's distroless images
- **Automatic Build** - Detects `package.json` and runs `npm install`

> **Note:** This buildpack uses a fixed Node.js version from Chainguard images, not the version specified in your `package.json` or `.nvmrc`.

## Example `package.json`

```json
{
  "name": "my-app",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.0"
  }
}
```

## Troubleshooting

**Build fails?** Ensure `package.json` exists and has a `start` script.

**App won't start?** Make sure your app listens on port `3000` or uses the `PORT` environment variable.

## Security Benefits

- Minimal attack surface (distroless)
- No shell or package managers in runtime
- Regularly updated base images
- CVE scanning and patching

---

Built with [Cloud Native Buildpacks](https://buildpacks.io) and [Chainguard Images](https://chainguard.dev)
