export RUSTFLAGS := "-C target-feature=+crt-static -C strip=symbols"
export ZERUS_VER := "v0.10.0"
export STATUSBAR_VER := "v0.3.5"
export BACKHAND_VER := "v0.18.0"

update-bins-static:
    cargo +stable install --target x86_64-unknown-linux-musl --root ~/cargo_bins --force --locked \
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
    just
    cargo +stable install --git https://github.com/wcampbell0x2a/aftermath.git --target x86_64-unknown-linux-musl --root ~/cargo_bins --force --locked
    cargo +stable install --git https://github.com/wcampbell0x2a/income.git --target x86_64-unknown-linux-musl --root ~/cargo_bins --force --locked
    curl -sL https://github.com/wcampbell0x2a/zerus/releases/download/$ZERUS_VER/zerus-$ZERUS_VER-x86_64-unknown-linux-musl.tar.gz | tar xz -C ~/cargo_bins 
    curl -sL https://github.com/wcampbell0x2a/statusbar/releases/download/$STATUSBAR_VER/statusbar-x86_64-unknown-linux-musl.tar.gz | tar xz -C ~/cargo_bins 
    curl -sL https://github.com/wcampbell0x2a/backhand/releases/download/$BACKHAND_VER/backhand-$BACKHAND_VER-x86_64-unknown-linux-musl.tar.gz | tar xz -C ~/cargo_bins 
