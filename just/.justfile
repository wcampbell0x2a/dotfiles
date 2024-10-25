export RUSTFLAGS := "-C target-feature=+crt-static -C strip=symbols"
export ZERUS_VER := "v0.10.0"
export STATUSBAR_VER := "v0.3.5"
export BACKHAND_VER := "v0.18.0"
export KOKIRI_VER := "v0.1.2"
export AFTERMATH_VER := "v0.1.1"

dl-gh-wc URL:
    just dl-gh https://github.com/wcampbell0x2a/{{URL}}

dl-gh URL:
    curl -sL {{URL}} | tar xz -C ~/cargo_bins/bin

update-bins-static:
    cargo +stable install --target x86_64-unknown-linux-musl --root ~/cargo_bins --locked \
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
        income
    just dl-gh-wc zerus/releases/download/$ZERUS_VER/zerus-$ZERUS_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc statusbar/releases/download/$STATUSBAR_VER/statusbar-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc backhand/releases/download/$BACKHAND_VER/backhand-$BACKHAND_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc kokiri/releases/download/$KOKIRI_VER/kokiri-$KOKIRI_VER-x86_64-unknown-linux-musl.tar.gz
    just dl-gh-wc aftermath/releases/download/$AFTERMATH_VER/aftermath-bin-$AFTERMATH_VER-x86_64-unknown-linux-musl.tar.gz
