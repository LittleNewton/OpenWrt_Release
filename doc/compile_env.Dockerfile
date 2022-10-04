### Stage 0: the base openwrt-compiling image
FROM debian:bullseye AS base

# TO DO 更换清华大学的 source.list
# RUN mv /etc/apt/sources.list && echo ""

# build dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends                               \
    # 1. Python
    python3             python3-setuptools  ipython3        python3-distutils       zsh         tmux        \
    # 2. build tools
    build-essential     gawk                gcc-multilib    flex                    clang       gettext     \
    # 3. ncurses
    libncurses5-dev     make                git             cmake                   wget        vim         \
    # 4. utils
    libssl-dev          rsync               unzip           zlib1g-dev              git         curl        \
    ca-certificates     openssh-server      &&              file    libcli-dev      libmspack-dev           \
    htop        libelf-dev &&      \
    apt-get clean &&                                                                                        \
    rm -rf /var/lib/apt/lists/*

# create a normal user because openwrt compilation not allow privileged user
ARG UNPRIVILEGED_USER=newton
ARG HOME_DIR=/home/${UNPRIVILEGED_USER}
RUN adduser newton --shell zsh && su "${UNPRIVILEGED_USER}"

# configure oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN mkdir ${HOME_DIR}/.zsh
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git  ${HOME_DIR}.zsh/zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-autosuggestions.git      ${HOME_DIR}.zsh/zsh-autosuggestions
RUN echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"    >> ${HOME_DIR}/.zshrc
RUN echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"            >> ${HOME_DIR}/.zshrc

# configure the ssh and add boot task
RUN mkdir ${HOME_DIR}/.ssh && \
    echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfKpoddM9WPRBrgY89Q/1t5+K0+I/rWEbvJUzEs/pGpg86GFvXCzg5Y2WSwweGxJ6q+xrVzEcPiEnyVx3u+WshQvDE8j/RtAH1OYIDgIJAojSrc3cmFHpH8vRyXkXCq7OXGm4aD1vXd3rXlco/G2riP5OLgrRaZE8Bg20ukZswss9zjTMyIybmHg1ZbMWdE/IR45sxGFXWeByJBgzsTR/T+BZE0EX5CUaOqQoeeN4tbej/GDzAFho3pAP1DzDHRwNxXvzW1nI51vRJ10v2YcQPOmAjZtPF3thG7bj5nP4iTA0m/oWsaqx+uB1vxQss+QxdHpFSrte0UVfxCj8J14vJ newton@Any_Computer' >> ${HOME_DIR}/.ssh/authorized_keys

# 添加开机自动启动 ssh 服务 service ssh start
