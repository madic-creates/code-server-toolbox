# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A tiny Dockerfile-only repo that extends the `codercom/code-server` base image with extra CLI tools (currently `sops` and `age`) for GitOps work on the sibling [`k3s-git-ops`](https://github.com/madic-creates/k3s-git-ops) repository. The resulting image is published to `ghcr.io/madic-creates/code-server-toolbox`.

There is no application code, no tests, and no runtime logic — just the `Dockerfile`, two GitHub Actions workflows, and a Renovate config.

## Build / run

Build locally (from repo root):

```bash
docker build -t code-server-toolbox:dev .
```

The real build is done by `.github/workflows/build.yaml` on every push to `main` that touches `Dockerfile` or the workflow itself. Each image is tagged with the short commit SHA, and `latest` on the default branch, via `docker/metadata-action`.

## How versions are managed (important)

**Do not hand-edit the `ARG *_VERSION=...` lines in `Dockerfile`.** Renovate owns them.

Each pinned tool has three coupled pieces in the Dockerfile:
1. A `# renovate: datasource=... depName=...` hint comment
2. An `ARG XXX_VERSION=...` line (this is what Renovate bumps)
3. A matching `curl ... ${XXX_VERSION} ...` step in the `RUN` block

To add a new tool, replicate all three pieces together — the comment must sit directly above the `ARG` for Renovate to pick it up.

Renovate policy (see `renovate.json`):
- Minor + patch → auto-merge
- Major → requires review
- `minimumReleaseAge: 5 days` — bumps wait before landing
- `ignoreTests: true` — auto-merge does not wait for CI

Renovate runs daily at 06:00 UTC via `.github/workflows/schedule_renovate.yaml` (self-hosted; uses `RENOVATE_TOKEN`). The workflow can also be dispatched manually with `dryRun`, `logLevel`, and `repoCache` inputs.

## Conventions

- Commit messages follow Conventional Commits (`feat:`, `ci:`, etc.) — match the style in `git log`.
- The `Dockerfile` intentionally ends with `USER coder` so the published image runs as the non-root code-server user; keep any new install steps inside the `USER root` block above it.
