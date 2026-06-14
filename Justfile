set lazy
set quiet
set script-interpreter := ['bash', '-euo', 'pipefail']
set shell := ['bash', '-euo', 'pipefail', '-c']

[private]
[script]
default:
    just --list

[doc('Build and test an app locally')]
[env("TESTCONTAINERS_RYUK_DISABLED", "true")]
[group('build')]
[script]
[working-directory('.cache')]
local-build app:
    export DOCKER_HOST="$(docker context inspect $(docker context show) -f '{{'{{'}} .Endpoints.docker.Host }}')"
    APP_DIR="{{ justfile_dir() / 'apps' / app }}"
    rsync -aqIP {{ justfile_dir() / 'include' }}/ "${APP_DIR}/" .
    docker buildx bake --metadata-file docker-bake.json --set=*.output=type=docker --load
    TEST_IMAGE="$(jq -r '."image-local"."image.name" | sub("^docker.io/library/"; "")' docker-bake.json)" go test -v "${APP_DIR}/..."
