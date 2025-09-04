FROM ubuntu:22.04

ARG ROOT_PASSWORD=3632

RUN apt update && \
    apt install openssh-server python3 python3-distutils python3-pip -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "root:${ROOT_PASSWORD}" | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    mkdir -p /var/run/sshd && \
    chmod 0755 /var/run/sshd

EXPOSE 22/tcp 389/tcp 636/tcp

ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]
