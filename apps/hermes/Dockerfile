ARG VERSION
FROM nousresearch/hermes-agent:${VERSION}

RUN npm install -g \
  # renovate: datasource=npm depName=obsidian-headless
  obsidian-headless@0.0.11 \
  # renovate: datasource=npm depName=@googleworkspace/cli
  @googleworkspace/cli@0.22.5
