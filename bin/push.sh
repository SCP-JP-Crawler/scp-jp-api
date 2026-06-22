#!/usr/bin/env bash
set -e
git config --global --add safe.directory "$PWD"
git config user.email "${GIT_EMAIL:-scp.jp.crawler@gmail.com}"
git config user.name "${GIT_USER:-SCP-JP-Crawler}"
git add docs
git commit -m "update data $(date -u +%Y-%m-%d)" || exit 0
git push origin main