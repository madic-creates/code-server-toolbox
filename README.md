# code-server-toolbox

`codercom/code-server` base image extended with extra CLI tools for day-to-day
GitOps work on the [k3s-git-ops](https://github.com/madic-creates/k3s-git-ops)
repository.

## Image

`ghcr.io/madic-creates/code-server-toolbox:latest`

Built by GitHub Actions on every push to `main` that touches `Dockerfile`
or the build workflow. Each build is also tagged with the short commit SHA.

## What's inside

| Tool | Source | Renovate-tracked via |
|------|--------|----------------------|
| code-server | `codercom/code-server` base image (FROM) | dockerfile manager |
| sops | https://github.com/getsops/sops | `ARG SOPS_VERSION` + `# renovate:` hint |
| age, age-keygen | https://github.com/FiloSottile/age | `ARG AGE_VERSION` + `# renovate:` hint |
| shfmt | https://github.com/mvdan/sh | `ARG SHFMT_VERSION` + `# renovate:` hint |

## Updating versions

Don't edit the `ARG` lines by hand — Renovate opens a PR whenever upstream cuts
a new release. Minor/patch PRs auto-merge; majors need review.

To add a new tool: append another `# renovate: datasource=... depName=...`
comment + `ARG XXX_VERSION=...` + install step in the `RUN` block.
