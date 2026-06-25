FROM rockylinux/rockylinux:10-minimal@sha256:bc5c1e7a2ec7f4bcef1e51c7f0ebb2d43f05409e0108cdd34f693921d0604360

WORKDIR /app

ARG VERSION
ARG UV_VERSION
ARG BUN_VERSION

ENV \
  PATH="${PATH}:/usr/local/bin:/app/.venv/bin:/app/node_modules/.bin" \
  PYTHON_VIRTUALENV=/app/.venv \
  UV_COMPILE_BYTECODE=0 \
  PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1 \
  HERMES_HOME=/data

RUN microdnf upgrade -y && \
    curl -fsSL https://rpm.nodesource.com/setup_24.x | bash - && \
    microdnf install -y make git gcc gcc-c++ nodejs tar && \
    microdnf clean all -y

COPY --from=ghcr.io/astral-sh/uv:0.11.24 /uv /uvx /usr/local/bin/

RUN useradd -u 1000 -M -U -s /bin/bash hermes

RUN uv python install 3.12 --install-dir /usr/local/share/uvpython
RUN uv venv --python 3.12
RUN uv pip install 'hermes-agent[cron,cli,pty,mcp,homeassistant,acp,web,google,messaging]==0.17.0' --prefix /app/.venv

# renovate: datasource=npm depName=obsidian-headless
ARG OBSIDIAN_HEADLESS_VERSION=0.0.12
# renovate: datasource=npm depName=@googleworkspace/cli
ARG GWS_CLI_VERSION=0.22.5
# renovate: datasource=github-releases depName=kubernetes/kubectl
ARG KUBECTL_VERSION=v1.36.2

ARG TARGETOS
ARG TARGETARCH

ARG NODE_GYP_FORCE_PYTHON=/app/.venv/bin/python

RUN npm install \
  obsidian-headless@${OBSIDIAN_HEADLESS_VERSION} \
  @googleworkspace/cli@${GWS_CLI_VERSION}

RUN curl -fsSL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl" -o /usr/local/bin/kubectl && \
  chmod +x /usr/local/bin/kubectl

COPY --chmod=0755 entrypoint.sh /entrypoint.sh

USER hermes

ENTRYPOINT [ "/entrypoint.sh" ]
