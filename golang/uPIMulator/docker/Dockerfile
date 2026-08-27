FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y git
RUN apt install -y wget
RUN apt install -y cmake
RUN apt install -y ninja-build
RUN apt install -y pkg-config
RUN apt install -y python3
RUN apt install -y python3-pip
RUN apt install -y libtinfo5

# UPMEM SDK
WORKDIR /root

RUN git clone --depth 1 \
    https://github.com/LangInteger/LoCaLUT.git \
    /root/LoCaLUT

RUN ln -s /root/LoCaLUT/upmem-2023.2.0-Linux-x86_64 \
    /root/upmem-2023.2.0-Linux-x86_64

RUN chmod a+x /root/upmem-2023.2.0-Linux-x86_64/upmem_env.sh && \
    chmod -R a+x /root/upmem-2023.2.0-Linux-x86_64/bin

ENV UPMEM_HOME=/root/upmem-2023.2.0-Linux-x86_64
ENV PATH="${UPMEM_HOME}/bin:${PATH}"
ENV LD_LIBRARY_PATH="${UPMEM_HOME}/lib"
ENV PYTHONPATH="${UPMEM_HOME}/lib/python3/dist-packages"
ENV UPMEM_NO_OS_WARNING=1

RUN dpu-upmem-dpurte-clang --version

WORKDIR /root/uPIMulator
