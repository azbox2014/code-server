ARG BASE_VERSION=latest
FROM docker.io/linuxserver/code-server:${BASE_VERSION}

RUN apt-get update && apt-get install -y \
    curl git zsh sudo ca-certificates unzip aria2 vim \
    && rm -rf /var/lib/apt/lists/*

# Oh My Zsh & 插件（放系统目录）
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git /opt/oh-my-zsh && \
    git clone https://github.com/romkatv/powerlevel10k.git /opt/oh-my-zsh/custom/themes/powerlevel10k && \
    git clone https://github.com/zsh-users/zsh-autosuggestions /opt/oh-my-zsh/custom/plugins/zsh-autosuggestions

# 设置默认 shell
RUN usermod -s /usr/bin/zsh abc

# 拷贝初始化脚本
COPY init-zsh.sh /usr/local/bin/init-zsh.sh
RUN chmod +x /usr/local/bin/init-zsh.sh

# 挂到 linuxserver 启动流程
RUN mkdir -p /custom-cont-init.d && \
    ln -s /usr/local/bin/init-zsh.sh /custom-cont-init.d/10-zsh-init
