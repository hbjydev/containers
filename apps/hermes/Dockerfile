ARG VERSION
FROM nousresearch/hermes-agent:${VERSION}

# renovate: datasource=npm depName=obsidian-headless
ARG OBSIDIAN_HEADLESS_VERSION=0.0.11
# renovate: datasource=npm depName=@googleworkspace/cli
ARG GWS_CLI_VERSION=0.22.5
# renovate: datasource=github-releases depName=kubernetes/kubectl
ARG KUBECTL_VERSION=v1.36.2

ARG TARGETOS
ARG TARGETARCH

RUN npm install -g \
  obsidian-headless@${OBSIDIAN_HEADLESS_VERSION} \
  @googleworkspace/cli@${GWS_CLI_VERSION}

RUN curl -fsSL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl" -o /usr/local/bin/kubectl && \
  chmod +x /usr/local/bin/kubectl
