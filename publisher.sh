#!/bin/bash

# Runs every 1 hour
# cron: "25 */1 * * *"

readonly ROOT=$(pwd)
readonly WEBAPP_REPO="WebApp"
readonly SECTIONS=( us world tech politics sports )
export $(grep -v '^#' "${ROOT}/.env" | xargs)

publish () {
  echo "[DEBUG] Run publish:"
  cd "${ROOT}" && git clone git@github.com:MajorDigest/${WEBAPP_REPO}.git
  # sudo apt-get update && sudo apt-get install ffmpeg
  cd "${WEBAPP_REPO}" && npm install && npm run publish
}

submit () {
  echo "[DEBUG] Run submit feeds"
  local url="https%3A%2F%2Fmajordigest.com"
  for section in "${SECTIONS[@]}"; do
    echo -n "Status (${section}): " && curl --silent -o /dev/null -w "%{http_code}\\n" \
      --data "hub.mode=publish&hub.url=${url}%2F${section}%2Ffeed.xml" \
      -X POST https://pubsubhubbub.appspot.com/
  done

  echo -n "Status (tech-feed-rev): " && curl --silent -o /dev/null -w "%{http_code}\\n" \
    --data "hub.mode=publish&hub.url=${url}%2Ftech%2Ffeed-rev.xml" \
    -X POST https://pubsubhubbub.appspot.com/
}

archive () {
  echo "[DEBUG] Run web archive"
  for section in "${SECTIONS[@]}"; do
    echo -n "Status (${section}): " && curl --silent -o /dev/null -w "%{http_code}\\n" \
      --data "url=https%3A%2F%2Fmajordigest.com%2F${section}%2F&capture_all=on" \
      -X POST "https://web.archive.org/save/https://majordigest.com/${section}/"
  done
}

cleanup () {
  echo "[DEBUG] Run cleanup"
  cd "${ROOT}"
  rm -rf "${WEBAPP_REPO}"
}

run () {
  publish
  submit
  archive
  cleanup
}

run
