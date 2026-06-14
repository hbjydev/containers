target "docker-metadata-action" {}

variable "APP" {
  default = "hermes"
}

variable "VERSION" {
  // renovate: datasource=docker depName=nousresearch/hermes-agent
  default = "v2026.6.5"
}

variable "SOURCE" {
  default = "https://github.com/NousResearch/hermes-agent"
}

variable "REGISTRY" {
  default = "forgejo.hayden.moe/hayden"
}

variable "GIT_SHA" {
  default = "dev"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION = "${VERSION}"
  }
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:${VERSION}"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64"
  ]
  tags = [
    "${REGISTRY}/${APP}:rolling",
    "${REGISTRY}/${APP}:${VERSION}-${substr(GIT_SHA, 0, 7)}"
  ]
}
