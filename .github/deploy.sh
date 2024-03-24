#!/bin/bash

validate_env() {
  if [ -z "${!1}" ]; then
    printf "${RED}%s\nVariable $1 is empty.\n%s\n${NC}" "$HR" "$HR"
    exit 1
  fi
}

############################################################
# Pre-Execution Checks                                     #
############################################################
ARCH=$(uname -m)
OS=$(uname -s)

if [ "$ARCH" = "x86_64" ]; then
    ARCH="amd64"
fi

if [ "$ARCH" != "amd64" ] && [ "$ARCH" != "arm64" ]; then
    echo "Error: Unsupported architecture ${ARCH}. Only amd64 and arm64 are supported."
    exit 1
fi

if [ "$OS" != "Linux" ] && [ "$OS" != "Darwin" ]; then
    echo "Error: Unsupported operating system ${OS}. Only Linux and Darwin are supported."
    exit 1
fi 

STATIC_BUCKET=${AWS_BUCKET}
validate_env "${STATIC_BUCKET}"

############################################################
# Define Global Variables                                  #
############################################################
ROOT_DIR=$(git rev-parse --show-toplevel)

POSTIFY_VERSION="0.0.1"
POSTIFY_NAME="postify"
POSTIFY_URL="https://github.com/Mad-Pixels/go-postify/releases/download/v${POSTIFY_VERSION}/${POSTIFY_NAME}-${OS}-${ARCH}"

STATIC_NAME="golang-etc"
STATIC_SOURCE_GIT_URL="https://github.com/Mad-Pixels/${STATIC_NAME}.git"

HR=$(printf '%*s\n' "80" '' | tr ' ' '=')
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

############################################################
# Download Postify                                         #
############################################################
echo -e "\n"
echo -e "${GREEN}Downloading Postify.${NC}"
echo -e "${YELLOW}$HR${NC}\n"

if curl -L "${POSTIFY_URL}" -o "${ROOT_DIR}/${POSTIFY_NAME}"; then
  chmod +x "${ROOT_DIR}/${POSTIFY_NAME}"
else
  echo "${RED}Failed to download Postify.${NC}" && exit 1
fi 

############################################################
# Generate Static Data                                     #
############################################################
echo -e "\n"
echo -e "${GREEN}Generate Static Sources.${NC}"
echo -e "${YELLOW}$HR${NC}\n"

echo -e "${GREEN}Download sources.${NC}"
if cd "${ROOT_DIR}" && git clone "${STATIC_SOURCE_GIT_URL}"; then
  echo -e "${GREEN}Start generate static data.${NC}"

  CONTENT_ALL=$(cd "${ROOT_DIR}/${STATIC_NAME}" && ls -d */)
  for dir in $CONTENT_ALL; do 
    if ! ${ROOT_DIR}/${POSTIFY_NAME} html-content \
      --with-router "${ROOT_DIR}/src/routes/content/router.json" \
      --with-tmpl "${ROOT_DIR}/assets/templates/content.svelte" \
      --to "${ROOT_DIR}/src/routes/content/${dir}" \
      --with-assets "${ROOT_DIR}/assets/content" \
      --from "${ROOT_DIR}/${STATIC_NAME}/${dir}" \
      --with-name +page.svelte;
    then
      echo "${RED}Execution failed, exit 1${NC}" && exit 1
    fi 
  done 
else 
  echo "${RED}Execution failed, exit 1${NC}" && exit 1
fi 

############################################################
# Build and Upload Static                                  #
############################################################
echo -e "\n"
echo -e "${GREEN}Build Static.${NC}"
echo -e "${YELLOW}$HR${NC}\n"

if cd "${ROOT_DIR}" && npm install --silent && npm run build; then
  echo -e "${GREEN}Upload static site.${NC}"

  if ! aws s3 sync ./build/ s3://"${AWS_BUCKET}--prd" --delete; then
    echo "${RED}Execution failed, exit 1${NC}" && exit 1
  fi
else
  echo "${RED}Execution failed, exit 1${NC}" && exit 1
fi

echo -e "\n"
echo -e "${GREEN}FINISH.${NC}"
echo -e "${YELLOW}$HR${NC}\n"
exit 0 

