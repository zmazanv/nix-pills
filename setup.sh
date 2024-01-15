unset PATH
for p in $baseInputs $buildInputs; do
    if [ -d $p/bin ]; then
        export PATH="$p/bin${PATH:+:}$PATH"
    fi
    if [ -d $p/lib/pkgconfig ]; then
        export PKG_CONFIG_PATH="$p/lib/pkgconfig${PKG_CONFIG_PATH:+:}$PKG_CONFIG_PATH"
    fi
done

unpackPhase() {
    tar xzf $src

    for d in *; do
        if [ -d "$d" ]; then
            cd "$d"
            break
        fi
    done
}

configurePhase() {
    ./configure --prefix=$out
}

buildPhase() {
    make
}

installPhase() {
    make install
}

fixupPhase() {
    find $out -type f -exec patchelf --shrink-rpath '{}' \; -exec strip '{}' \; 2>/dev/null
}

genericBuild() {
    unpackPhase
    configurePhase
    buildPhase
    installPhase
    fixupPhase
}
