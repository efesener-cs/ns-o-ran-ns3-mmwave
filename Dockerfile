FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /workspace

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    cmake \
    git \
    libeigen3-dev \
    libgsl-dev \
    libsqlite3-dev \
    libxml2-dev \
    ninja-build \
    pkg-config \
    python3 \
    && rm -rf /var/lib/apt/lists/*

COPY . /workspace

ARG BUILD_JOBS=2
RUN ./ns3 configure --disable-python-bindings --enable-examples --disable-gtk \
    && ./ns3 build -j ${BUILD_JOBS}

CMD ["/bin/bash"]
