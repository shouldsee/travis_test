#!/bin/sh

GITHUB_BRANCH=${GITHUB_BRANCH:-gh-pages}
GITHUB_TOKEN=${GITHUB_TOKEN}
GITHUB_PATH=${GITHUB_PATH}

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit_website_files() {
  git checkout -b $GITHUB_BRANCH
#   gh-pages
#   find . | tee LOCAL_INDEX
#   cat ../.gitignore
#   git add ../ --all
#   git status ../
#  git add . *.html
  git status
  git add --all
  git commit --message "Travis build: $TRAVIS_BUILD_NUMBER"
}


upload_files() {
  git remote add origin-pages https://${GITHUB_TOKEN}@github.com/${GITHUB_PATH}.git > /dev/null 2>&1
  git push --quiet --set-upstream origin-pages ${GITHUB_BRANCH} --force
}

setup_git
commit_website_files
upload_files
