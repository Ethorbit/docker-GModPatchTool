FROM rust:1.90 AS base

ARG UID=1000
ARG GID=1000

VOLUME /home/gmod/.steam/steam

# Create user
RUN groupadd -g "${GID}" gmod &&\
    useradd -g gmod -u "${UID}" gmod &&\
    mkdir -p /home/gmod/.steam/steam &&\
    mkdir -p /home/gmod/.cache &&\
    chown -R gmod:gmod /home/gmod/ &&\
    chmod -R 750 /home/gmod/

FROM base AS project

# Install system dependencies + Git LFS
RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    git \
    curl \
    git-lfs \
    && rm -rf /var/lib/apt/lists/*

USER gmod
WORKDIR /home/gmod

# Initialize Git LFS
RUN git lfs install --system

# Clone the repo and fetch LFS files
RUN git clone https://github.com/solsticegamestudios/GModPatchTool.git ./GModPatchTool \
    && cd ./GModPatchTool \
    && git checkout 355d6e9e6b4c838c5bbf36ee2be6495ef16ffb9b \
    && git lfs pull \
    && cargo build --release

# Optional: make binary accessible
ENV PATH="./GModPatchTool/target/release:${PATH}"

ENTRYPOINT [ "./GModPatchTool/target/release/gmodpatchtool" ]
# CMD [ "-steam_path", "/home/gmod/.steam/steam" ]
