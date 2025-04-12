#!/bin/bash
#required by toggle-translate.sh

CONTAINER_NAME="libretranslate"

# 检查是否已经有容器在跑
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}\$"; then
  echo "Container ${CONTAINER_NAME} already exists."
  docker start ${CONTAINER_NAME}
  echo "now started"
else
  echo "Creating and starting new LibreTranslate container..."
  docker run -d --name libretranslate \
    -p 5000:5000 \
    -e LT_LOAD_ONLY=en,zh \
    -e LT_HOST=0.0.0.0 \
    libretranslate/libretranslate
fi
