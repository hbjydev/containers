FROM rockylinux/rockylinux:10-minimal@sha256:bc5c1e7a2ec7f4bcef1e51c7f0ebb2d43f05409e0108cdd34f693921d0604360

WORKDIR /app

ARG VERSION

ENV PATH="${PATH}:/usr/local/bin:/app/node_modules/.bin"

RUN microdnf upgrade -y && \
    curl -fsSL https://rpm.nodesource.com/setup_24.x | bash - && \
    microdnf install -y make git gcc gcc-c++ nodejs tar opus && \
    microdnf clean all -y

RUN useradd -u 1000 -m -U -s /bin/bash openclaw

ARG TARGETOS
ARG TARGETARCH

RUN npm config set allow-scripts=openclaw && \
  npm install "openclaw@${VERSION}"

ENV MISE_INSTALL_PATH=/usr/local/bin/mise
RUN curl -fsSL https://mise.run -o /tmp/install-mise.sh \
    && sh /tmp/install-mise.sh \
    && rm /tmp/install-mise.sh

COPY --chmod=0755 entrypoint.sh /entrypoint.sh

USER openclaw

RUN activation='eval "$(mise activate bash)"' \
    && grep -qxF "$activation" ~/.bashrc 2>/dev/null || printf '%s\n' "$activation" >> ~/.bashrc

ENTRYPOINT [ "/entrypoint.sh" ]
