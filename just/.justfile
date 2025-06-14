set shell := ["bash", "-c"]

# Version of rust to use for build container
export RUST_VER := "1.85.1"

# Progam versions
export ZERUS_VER := "v0.11.0"
export STATUSBAR_VER := "v0.3.5"
export BACKHAND_VER := "v0.21.0"
export KOKIRI_VER := "v0.1.2"
export AFTERMATH_VER := "v0.1.1"
export HERETEK_VER := "v0.5.1"
export HELIX_VER := "25.01.1"
export ALACRITTY_VER := "v0.15.1"
export DIFFTASTIC_VER := "0.63.0"
export MERGIRAF_VER := "v0.7.0"
export STARSHIP_VER := "v1.23.0"
export JUST_VER := "1.40.0"
export HEXYL_VER := "v0.16.0"
export GIT_ABSORB_VER := "0.8.0"
export EZA_VER := "v0.21.3"
export DUST_VER := "v1.2.0"
export ZOXIDE_VER := "0.9.7"
export RIPGREP_VER := "14.1.1"
export BAT_VER := "v0.25.0"
export FD_VER := "v10.2.0"
export VIVID_VER := "v0.10.1"
export HYPERFINE_VER := "v1.19.0"
export NEXTEST_VER := "0.9.98"

dl-gh-wc URL:
    just dl-tar https://github.com/wcampbell0x2a/{{URL}}

# Extract entire tar
dl-tar URL:
    curl -sL {{URL}} | tar xz -C ~/offline/bin

# Extract single file in tar
dl-tar-file URL FILE:
    curl -sL {{URL}} | tar xz -C ~/offline/bin {{FILE}} 

# Extract single file in tar, in folder that needs to be deleted
dl-tar-file-rm-folder URL FILE:
    just dl-tar-file {{URL}} {{FILE}}
    mv ~/offline/bin/{{FILE}} ~/offline/bin/$(basename {{FILE}})
    rm -rf ~/offline/bin/$(dirname {{FILE}})

update-offline-cargo-crates:
    @echo {{BLUE}}Updating offline built cargo bins {{NORMAL}}
    rm -rf ~/offline/cargo

    # static musl no-symbols from crates.io
    set -e RUSTFLAGS="-C target-feature=+crt-static -C strip=symbols"
    cargo +stable install --target x86_64-unknown-linux-musl --root ~/offline/cargo --locked \
        ropr \
        svgbob_cli \
        checksec \
        income \
        heh \
        cargo-asm \
        cargo-expand \
        cargo-bloat

update-offline-dl:
    @echo {{BLUE}}Updating offline downloaded bins {{NORMAL}}
    mkdir -p ~/offline/bin
    # install from github releases
    just dl-gh-wc              zerus/releases/download/$ZERUS_VER/zerus-$ZERUS_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc              statusbar/releases/download/$STATUSBAR_VER/statusbar-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc              backhand/releases/download/$BACKHAND_VER/backhand-$BACKHAND_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc              kokiri/releases/download/$KOKIRI_VER/kokiri-$KOKIRI_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc              aftermath/releases/download/$AFTERMATH_VER/aftermath-bin-$AFTERMATH_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc              heretek/releases/download/$HERETEK_VER/heretek-$HERETEK_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-tar                https://github.com/Wilfred/difftastic/releases/download/$DIFFTASTIC_VER/difft-x86_64-unknown-linux-musl.tar.gz
    just dl-tar                https://codeberg.org/mergiraf/mergiraf/releases/download/$MERGIRAF_VER/mergiraf_x86_64-unknown-linux-musl.tar.gz
    just dl-tar                https://github.com/starship/starship/releases/download/$STARSHIP_VER/starship-x86_64-unknown-linux-musl.tar.gz
    just dl-tar-file           https://github.com/casey/just/releases/download/$JUST_VER/just-$JUST_VER-x86_64-unknown-linux-musl.tar.gz just
    just dl-tar-file-rm-folder https://github.com/sharkdp/hexyl/releases/download/$HEXYL_VER/hexyl-$HEXYL_VER-x86_64-unknown-linux-musl.tar.gz hexyl-v0.16.0-x86_64-unknown-linux-musl/hexyl
    just dl-tar-file-rm-folder https://github.com/tummychow/git-absorb/releases/download/$GIT_ABSORB_VER/git-absorb-$GIT_ABSORB_VER-x86_64-unknown-linux-musl.tar.gz git-absorb-$GIT_ABSORB_VER-x86_64-unknown-linux-musl/git-absorb
    just dl-tar                https://github.com/eza-community/eza/releases/download/$EZA_VER/eza_x86_64-unknown-linux-musl.tar.gz
    just dl-tar-file-rm-folder https://github.com/bootandy/dust/releases/download/$DUST_VER/dust-$DUST_VER-x86_64-unknown-linux-musl.tar.gz dust-$DUST_VER-x86_64-unknown-linux-musl/dust
    just dl-tar-file           https://github.com/ajeetdsouza/zoxide/releases/download/v$ZOXIDE_VER/zoxide-$ZOXIDE_VER-x86_64-unknown-linux-musl.tar.gz zoxide
    just dl-tar-file-rm-folder https://github.com/BurntSushi/ripgrep/releases/download/$RIPGREP_VER/ripgrep-$RIPGREP_VER-x86_64-unknown-linux-musl.tar.gz ripgrep-$RIPGREP_VER-x86_64-unknown-linux-musl/rg
    just dl-tar-file-rm-folder https://github.com/sharkdp/bat/releases/download/$BAT_VER/bat-$BAT_VER-x86_64-unknown-linux-musl.tar.gz bat-$BAT_VER-x86_64-unknown-linux-musl/bat
    just dl-tar-file-rm-folder https://github.com/sharkdp/fd/releases/download/$FD_VER/fd-$FD_VER-x86_64-unknown-linux-musl.tar.gz fd-$FD_VER-x86_64-unknown-linux-musl/fd
    just dl-tar-file-rm-folder https://github.com/sharkdp/vivid/releases/download/$VIVID_VER/vivid-$VIVID_VER-x86_64-unknown-linux-musl.tar.gz vivid-$VIVID_VER-x86_64-unknown-linux-musl/vivid
    just dl-tar-file-rm-folder https://github.com/sharkdp/hyperfine/releases/download/$HYPERFINE_VER/hyperfine-$HYPERFINE_VER-x86_64-unknown-linux-musl.tar.gz hyperfine-$HYPERFINE_VER-x86_64-unknown-linux-musl/hyperfine
    just dl-tar                https://github.com/nextest-rs/nextest/releases/download/cargo-nextest-$NEXTEST_VER/cargo-nextest-$NEXTEST_VER-x86_64-unknown-linux-musl.tar.gz

update-offline-bins:
    @echo {{BLUE}}Updating offline built special bins {{NORMAL}}
    # cargo cross git source
    cargo +stable install --target x86_64-unknown-linux-musl --root ~/offline --locked \
        cross --git https://github.com/cross-rs/cross

    # harper-ls needs to be built dynamic, so we just use scuba image of an old debian
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
    @echo {{BLUE}}Updating offline other {{NORMAL}}
    # my dotfile
    tmpdir=$(mktemp -d) && pushd $tmpdir \
        && git clone https://github.com/wcampbell0x2a/dotfiles.git \
        && tar -cvzf ~/offline/dotfiles.tar.gz . \
        && popd && rm -rf $tmpdir

    # font
    curl -svL https://wcampbell.dev/public/berkeley-mono-typeface-zero.zip -o ~/offline/berkely-mono-typeface-zero.zip

update-offline: update-offline-cargo-crates update-offline-dl update-offline-bins update-offline-other
    @echo {{BLUE}}Updated ~/offline {{NORMAL}}
