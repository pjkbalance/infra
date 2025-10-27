#!/usr/bin/env zsh

function create_docker_compose() {
    local DOCKER_COMPOSE_NAME=$1
    local dir="./docker-compose.yaml"
    if [ ! -f "$dir" ]; then
        touch "$dir"
    fi
    cat >"$dir" <<EOF
services:
  ${DOCKER_COMPOSE_NAME}:
    image: xxxx
    ports:
      - "xxxx:xxxx"
    volumes:
      - volumes/xxxx:xxxx
    env_file:
      - .env
EOF
}

function create_env_file() {
    local dir="./.env.sample"
    if [ ! -f "$dir" ]; then
        touch "$dir"
    fi
    echo "EXAMPLE_PARAMETER=xxx" >> "$dir"
}

function initial_docker_compose() {
    get_input "📝 Enter the name: "
    DOCKER_COMPOSE_NAME=$result
    if [ -d "./${DOCKER_COMPOSE_NAME}" ]; then
      echo "❗ Directory ./${DOCKER_COMPOSE_NAME} already exists. Exiting."
      return 1
    fi
    mkdir "./${DOCKER_COMPOSE_NAME}"
    cd "./${DOCKER_COMPOSE_NAME}"
    create_docker_compose ${DOCKER_COMPOSE_NAME}
    create_env_file
    if [ ! -d "./volumes" ]; then
      mkdir "./volumes"
    fi
}