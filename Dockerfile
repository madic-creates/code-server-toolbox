FROM codercom/code-server:4.117.0

# renovate: datasource=github-releases depName=getsops/sops
ARG SOPS_VERSION=v3.12.2
# renovate: datasource=github-releases depName=FiloSottile/age
ARG AGE_VERSION=v1.2.1

USER root

# hadolint ignore=DL3008
RUN set -eux \
 && curl -sSfL -o /usr/local/bin/sops \
      "https://github.com/getsops/sops/releases/download/${SOPS_VERSION}/sops-${SOPS_VERSION}.linux.amd64" \
 && chmod 0755 /usr/local/bin/sops \
 && sops --version \
 && curl -sSfL "https://github.com/FiloSottile/age/releases/download/${AGE_VERSION}/age-${AGE_VERSION}-linux-amd64.tar.gz" \
      | tar -xz --strip-components=1 -C /usr/local/bin age/age age/age-keygen \
 && chmod 0755 /usr/local/bin/age /usr/local/bin/age-keygen \
 && age --version

USER coder
