set shell := ["bash", "-c"]
export ZERUS_VER := "v0.11.0"
export STATUSBAR_VER := "v0.3.5"
export BACKHAND_VER := "v0.21.0"
export KOKIRI_VER := "v0.1.2"
export AFTERMATH_VER := "v0.1.1"
export HERETEK_VER := "v0.5.0"
export HELIX_VER := "25.01.1"
export ALACRITTY_VER := "v0.15.1"
export DIFFTASTIC_VER := "0.63.0"
export RUST_VER := "1.85.1"

dl-gh-wc URL:
    just dl-gh https://github.com/wcampbell0x2a/{{URL}}

dl-gh URL:
    curl -sL {{URL}} | tar xz -C ~/cargo_bins/bin

update-offline-cargo-crates:
    rm -rf ~/offline/cargo

    # static musl no-symbols from crates.io
    set -e RUSTFLAGS="-C target-feature=+crt-static -C strip=symbols"
    cargo +stable install --target x86_64-unknown-linux-musl --root ~/offline/cargo --locked \
        vivid \
        fd-find \
        bat \
        ropr \
        exa \
        zoxide \
        du-dust \
        hexyl \
        git-absorb \
        svgbob_cli \
        checksec \
        repgrep \
        just \
        income \
        heh \
        cargo-asm \
        cargo-expand \
        cargo-bloat

update-offline-gh:
    # install from github releases
    just dl-gh-wc zerus/releases/download/$ZERUS_VER/zerus-$ZERUS_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc statusbar/releases/download/$STATUSBAR_VER/statusbar-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc backhand/releases/download/$BACKHAND_VER/backhand-$BACKHAND_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc kokiri/releases/download/$KOKIRI_VER/kokiri-$KOKIRI_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc aftermath/releases/download/$AFTERMATH_VER/aftermath-bin-$AFTERMATH_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc heretek/releases/download/$HERETEK_VER/heretek-$HERETEK_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-gh https://github.com/Wilfred/difftastic/releases/download/$DIFFTASTIC_VER/difft-x86_64-unknown-linux-musl.tar.gz

update-offline-bins:
    # cargo cross git source
    cargo +stable install --target x86_64-unknown-linux-musl --root ~/offline --locked \
        cross --git https://github.com/cross-rs/cross

    # harpser-ls needs to be built dynamic, so we just use scuba image of an old debian
    set -e RUSTFLAGS="-C target-feature=-crt-static -C strip=symbols"
    tmpdir=$(mktemp -d) && pushd $tmpdir \
        && scuba --image rust:$RUST_VER-bullseye cargo install harper-ls --locked --root ./offline \
        && mv offline/bin/harper-ls ~/offline/bin/ \
        && popd && rm -rf $tmpdir

    # helix needs to be built dynamic, so we just use scuba image of an old debian
    set -e RUSTFLAGS="-C target-feature=-crt-static -C strip=symbols"
    tmpdir=$(mktemp -d) && pushd $tmpdir \
        && git clone https://github.com/helix-editor/helix --branch $HELIX_VER \
        && cd helix \
        && scuba --image rust:$RUST_VER-bullseye cargo build --release -p helix-term --target x86_64-unknown-linux-gnu \
        && mv ./target/x86_64-unknown-linux-gnu/release/hx ~/offline/hx \
        && tar -cvzf ~/offline/helix-runtime.tar.gz runtime \
        && popd && rm -rf $tmpdir

    # Following https://github.com/alacritty/alacritty/blob/master/INSTALL.md
    set -e RUSTFLAGS "-C target-feature=-crt-static -C strip=symbols"
    tmpdir=$(mktemp -d) && pushd $tmpdir \
        && git clone https://github.com/alacritty/alacritty --branch $ALACRITTY_VER \
        && cd alacritty \
        && echo -e '[build]\npre-build = [\n"DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3"\n]' > Cross.toml \
        && cross +stable build --release --locked \
        && mv ./target/x86_64-unknown-linux-gnu/release/alacritty ~/offline/alacritty \
        && popd && rm -rf $tmpdir

    # rust self-installer, mostly for rust-analyzer
    curl -svL https://static.rust-lang.org/dist/rust-$RUST_VER-x86_64-unknown-linux-musl.tar.xz -o ~/offline/rust-$RUST_VER-x86_64-unknown-linux-musl.tar.xz
    curl -svL https://static.rust-lang.org/dist/rust-$RUST_VER-x86_64-unknown-linux-gnu.tar.xz -o ~/offline/rust-$RUST_VER-x86_64-unknown-linux-gnu.tar.xz

update-offline-other:
    # my dotfile
    tmpdir=$(mktemp -d) && pushd $tmpdir \
        && git clone https://github.com/wcampbell0x2a/dotfiles.git \
        && tar -cvzf ~/offline/dotfiles.tar.gz . \
        && popd && rm -rf $tmpdir

    # font
    curl -svL https://wcampbell.dev/public/berkeley-mono-typeface-zero.zip -o ~/offline/berkely-mono-typeface-zero.zip

update-offline: update-offline-cargo-crates update-offline-gh update-offline-bins update-offline-other
