# Copyright 2020, Trevor Sundberg. See LICENSE.md
FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        cmake \
        clang \
        lld \
        git \
        curl \
        nodejs \
        npm \
        python3 \
        python3-pip \
        dumb-init

# Emscripten SDK
RUN git clone https://github.com/emscripten-core/emsdk.git /opt/emsdk && \
    cd /opt/emsdk && \
    ./emsdk install 4.0.11 && \
    ./emsdk activate 4.0.11
ENV EMSDK="/opt/emsdk"
ENV PATH="/opt/emsdk:/opt/emsdk/upstream/emscripten:${PATH}"

# Wabt (WebAssembly Binary Toolkit)
RUN curl -LO https://github.com/WebAssembly/wabt/releases/download/1.0.37/wabt-1.0.37-ubuntu-20.04.tar.gz && \
    tar -xzf wabt-1.0.37-ubuntu-20.04.tar.gz && \
    mv wabt-1.0.37 /opt/wabt && \
    rm wabt-1.0.37-ubuntu-20.04.tar.gz
ENV PATH="/opt/wabt/bin:${PATH}"
ENV WABT_INCLUDE_DIR="/opt/wabt/include"
ENV WABT_LIB_DIR="/opt/wabt/lib"

# Binaryen
RUN curl -LO https://github.com/WebAssembly/binaryen/releases/download/version_123/binaryen-version_123-x86_64-linux.tar.gz && \
    tar -xzf binaryen-version_123-x86_64-linux.tar.gz && \
    mv binaryen-version_123 /opt/binaryen && \
    rm binaryen-version_123-x86_64-linux.tar.gz
ENV PATH="/opt/binaryen/bin:${PATH}"

# Wasi SDK
RUN curl -LO https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-25/wasi-sdk-25.0-x86_64-linux.deb && \
    dpkg -i wasi-sdk-25.0-x86_64-linux.deb && \
    rm wasi-sdk-25.0-x86_64-linux.deb
ENV PATH="/opt/wasi-sdk/bin:${PATH}"
ENV WASI_SDK_PATH="/opt/wasi-sdk"

# Wasmer
RUN curl https://get.wasmer.io -sSfL | sh

# Rust
ENV RUSTUP_HOME=/opt/rust
ENV CARGO_HOME=/opt/rust
ENV PATH="/opt/rust/bin:${PATH}"
RUN curl -sSf https://sh.rustup.rs | bash -s -- -y --default-toolchain=1.81.0
RUN rustup target add wasm32-wasi
RUN cargo install --locked cargo-wasi

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD echo "No command specified"
