#!/bin/bash

if [ -z "$1" ]; then
    echo "Erro: Por favor, forneça um nome como parâmetro."
    echo "Uso: ./setup.sh <Nome>"
    exit 1
fi

NOME=$1

docker buildx build \
    --platform linux/arm64 \
    -t ${NOME}/rpi-game-dev:latest-arm64 \
    --output type=docker \
    .
