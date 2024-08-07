#/usr/bin/bash
set -ex
RUSTFLAGS="-C target-feature=+crt-static -C strip=symbols" cargo install --root ~/cargo_bins --force --locked --target x86_64-unknown-linux-musl \
  fd-find \
  bat \
  statusbar \
  starship \
  ropr \
  exa \
  zoxide \
  du-dust \
  hexyl \
  git-absorb \
  svgbob_cli
