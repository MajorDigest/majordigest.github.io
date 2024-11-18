#!/bin/bash

# Runs at midnigth
# cron: "0 0 * * *"

readonly CWD=$(pwd)
readonly BASENAME=$(basename "$0")
readonly FILENAME="${BASENAME%%.*}"
readonly ROOT="${CWD}/${FILENAME}"
readonly DEPLOY_REPO="majordigest.github.io"

export $(grep -v '^#' "${CWD}/.env" | xargs -0)

config () {
  echo "[DEBUG] Run git config"
  git config --local user.name "$GITHUB_USER"
  git config --local user.email "41898282+$GITHUB_USER@users.noreply.github.com"
}

archive () {
  echo "[DEBUG] Run archive"
  cd "${ROOT}" && git clone "git@github.com:MajorDigest/${DEPLOY_REPO}.git"
  cd "${DEPLOY_REPO}"

  export ARCHIVE_DATE="$(TZ=America/New_York date '+%Y/%m/%d')"
  export LAST_MODIFIED="$(TZ=America/New_York date '+%Y-%m-%d')"
  export ARCHIVE_PATH="archive/${ARCHIVE_DATE}"
  export IMAGE_TIMESTAMP="$(TZ=America/New_York date '+%Y%m%d')"
  export IMAGE_SRC_PATTERN="src=\"/assets/images/"
  export IMAGE_REPLACEMENT="src=\"https://web.archive.org/web/${IMAGE_TIMESTAMP}im_/https://majordigest.com/assets/images/"
  export CANONICAL_URL_PATTERN="=\"https://majordigest.com/\">"
  export CANONICAL_REPLACEMENT="=\"https://majordigest.com/${ARCHIVE_PATH}/\">"
  export ARCHIVE_LINK_PLACEHOLDER="<!--archive-->"
  export ARCHIVE_LINK_TEXT="$(TZ=America/New_York date '+%B %-d, %Y')"
  export ARCHIVE_LINK="${ARCHIVE_LINK_PLACEHOLDER}\n<a href=\"/${ARCHIVE_PATH}/\" title=\"News archive of ${ARCHIVE_LINK_TEXT}\">${ARCHIVE_LINK_TEXT}</a>"
  export SITEMAP_LINK="${ARCHIVE_LINK_PLACEHOLDER}\n<url><loc>https://majordigest.com/${ARCHIVE_PATH}/</loc><lastmod>${LAST_MODIFIED}</lastmod><changefreq>never</changefreq></url>"
  export PRECONNECT_PLACEHOLDER="</head>"
  export PRECONNECT_REPLACEMENT="<link rel=\"preconnect\" href=\"https://web.archive.org/\"></head>"

  echo "ARCHIVE_PATH: ${ARCHIVE_PATH}"
  mkdir -p "${ARCHIVE_PATH}"
  cp index.html "${ARCHIVE_PATH}"
  sed -i -e "s#$IMAGE_SRC_PATTERN#$IMAGE_REPLACEMENT#g" "${ARCHIVE_PATH}/index.html"
  sed -i -e "s#$CANONICAL_URL_PATTERN#$CANONICAL_REPLACEMENT#g" "${ARCHIVE_PATH}/index.html"
  sed -i -e "s#$PRECONNECT_PLACEHOLDER#$PRECONNECT_REPLACEMENT#g" "${ARCHIVE_PATH}/index.html"
  sed -i -e "s#$ARCHIVE_LINK_PLACEHOLDER#$ARCHIVE_LINK#g" "archive/index.html"
  sed -i -e "s#$ARCHIVE_LINK_PLACEHOLDER#$SITEMAP_LINK#g" "archive/sitemap.xml"

  config
  git add -A && git commit -m "Added archive for ${ARCHIVE_DATE}"
  git push https://$GITHUB_USER:$GITHUB_ACCESS_TOKEN@github.com/MajorDigest/$DEPLOY_REPO.git
}

rebase () {
  echo "[DEBUG] Run rebase"
  export LAST_COMMIT="$(git rev-parse HEAD)"
  export TEMP_BRANCH="temp$RANDOM"

  config
  echo "[DEBUG] Run checkout:"
  git checkout --orphan $TEMP_BRANCH $LAST_COMMIT
  echo "[DEBUG] Run commit:"
  git commit --allow-empty -m "Truncated history"
  echo "[DEBUG] Run rebase:"
  git rebase --onto $TEMP_BRANCH $LAST_COMMIT main
  echo "[DEBUG] Delete $TEMP_BRANCH branch:"
  git branch -D $TEMP_BRANCH
  echo "[DEBUG] Delete all the objects w/o references:"
  git prune --progress
  echo "[DEBUG] Run git status:"
  git status
  echo "[DEBUG] Run git push:"
  # git push -f
  git push -f https://$GITHUB_USER:$GITHUB_ACCESS_TOKEN@github.com/MajorDigest/$DEPLOY_REPO.git
}

cleanup () {
  echo "[DEBUG] Run cleanup"
  cd "${ROOT}"
  rm -rf "${DEPLOY_REPO}"
}

run () {
  archive
  rebase
  cleanup
}

run
