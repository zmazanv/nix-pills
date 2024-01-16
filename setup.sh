# shellcheck disable=2154,2164

unset PATH
# `$baseInputs` and `$buildInputs` are space-separated strings.
for p in ${baseInputs} ${buildInputs}; do
    # Make input `bin` directories available in `PATH`.
    if [ -d "${p}/bin" ]; then
        export PATH="${p}/bin${PATH:+:}${PATH}"
    fi
    # Make input `lib/pkgconfig` directories available in `PKG_CONFIG_PATH`.
    if [ -d "${p}/lib/pkgconfig" ]; then
        export PKG_CONFIG_PATH="${p}/lib/pkgconfig${PKG_CONFIG_PATH:+:}${PKG_CONFIG_PATH}"
    fi
done

# Unpack tarball and enter its unpacked directory.
function unpackPhase {
    tar xzf "${src}"
    for d in *; do
        if [ -d "${d}" ]; then
            cd "${d}"
            break
        fi
    done
}

# Run `configure` shell script ensuring output directory is set to `$out`.
function configurePhase {
    ./configure --prefix="${out}"
}

# Build the output.
function buildPhase {
    make
}

# Install the output.
function installPhase {
    make install
}

# Strip unneeded runtime dependencies.
function fixupPhase {
    find "${out}" -type f -exec patchelf --shrink-rpath '{}' \; -exec strip '{}' \; 2>/dev/null
}

# Run entire build and install process.
function genericBuild {
    unpackPhase
    configurePhase
    buildPhase
    installPhase
    fixupPhase
}
