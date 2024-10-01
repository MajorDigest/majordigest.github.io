#!/bin/bash

# Runs every 1 hour
# cron: "0 */1 * * *"

readonly ROOT=$(pwd)
readonly WEBAPP_REPO="WebApp"
readonly IMAGES_REPO="static10"
readonly DEPLOY_REPO="majordigest.github.io"
readonly PROFILE_DIR="MajorDigest"

export $(grep -v '^#' "${ROOT}/.env" | xargs -0)

config () {
  echo "[DEBUG] Run git config"
  git config --local user.name "$GITHUB_USER"
  git config --local user.email "41898282+$GITHUB_USER@users.noreply.github.com"
  echo "[DEBUG] Run git config: Done"
}

build () {
  echo "[DEBUG] Run npm build"
  cd "${ROOT}" && git clone git@github.com:MajorDigest/${WEBAPP_REPO}.git
  cd "${WEBAPP_REPO}" && npm install && export STATIC_REPO="${IMAGES_REPO}" && npm run build
  rm -rf package.json package-lock.json android node_modules templates pages
  rm -rf .git .github .gitignore
  echo "[DEBUG] Run npm build: Done"
}

images () {
  echo "[DEBUG] Run copy images"
  cd "${ROOT}" && git clone "git@github.com:MajorDigest/${IMAGES_REPO}.git"
  cd "${ROOT}"
  cp -rf "${WEBAPP_REPO}"/tmp/assets/images/* "${IMAGES_REPO}/"
  rm -rf "${WEBAPP_REPO}/tmp/"
  cd "${IMAGES_REPO}"
  config
  git add -A && git commit -m "Deploy Images: $(TZ=America/Los_Angeles date '+%Y/%m/%d %H:%M')"
  git push https://$GITHUB_USER:$GITHUB_ACCESS_TOKEN@github.com/MajorDigest/$IMAGES_REPO.git
  echo "[DEBUG] Run copy images: Done"
}

deploy () {
  echo "[DEBUG] Run deploy"
  cd "${ROOT}" && git clone "git@github.com:MajorDigest/${DEPLOY_REPO}.git"
  cd "${ROOT}"
  cp -R "${WEBAPP_REPO}/" "${DEPLOY_REPO}/"
  cd "${DEPLOY_REPO}"
  config
  rm -rf builder.sh midnigth.sh publisher.sh
  git add -A && git commit -m "Deploy WebApp: $(TZ=America/Los_Angeles date '+%Y/%m/%d %H:%M')"
  git push https://$GITHUB_USER:$GITHUB_ACCESS_TOKEN@github.com/MajorDigest/$DEPLOY_REPO.git
  echo "[DEBUG] Run deploy: Done"
}

profile () {
  echo "[DEBUG] Run profile"
  cd "${ROOT}" && git clone "git@github.com:MajorDigest/${PROFILE_DIR}.git"
  cd "${ROOT}"
  cp "${WEBAPP_REPO}/README.md" "${PROFILE_DIR}/"
  cd "${PROFILE_DIR}"
  config
  git add -A && git status
  echo "diff exit-code: $(git diff --exit-code)"
  git diff --exit-code || git commit -m "Update Profile: $(TZ=America/Los_Angeles date '+%Y/%m/%d %H:%M')"
  git push https://$GITHUB_USER:$GITHUB_ACCESS_TOKEN@github.com/MajorDigest/$PROFILE_DIR.git
  echo "[DEBUG] Run profile: Done"
}

cleanup () {
  echo "[DEBUG] Run cleanup"
  cd "${ROOT}"
  rm -rf "${WEBAPP_REPO}"
  rm -rf "${IMAGES_REPO}"
  rm -rf "${DEPLOY_REPO}"
  rm -rf "${PROFILE_DIR}"
  echo "[DEBUG] Run cleanup: Done"
}

run () {
  build
  images
  deploy
  profile
  cleanup
}

run
