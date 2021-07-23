# syntax=docker/dockerfile:1

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

RUN apt-get update \
    && apt-get install -y \
    git curl build-essential \
    software-properties-common \
    wget

RUN add-apt-repository -y ppa:neovim-ppa/unstable \
    && apt-get update \
    && apt-get install -y neovim

# Create user void of root privileges - run a more secure container
RUN useradd -ms /bin/bash dev
WORKDIR /home/dev
ENV HOME /home/dev

# Install bash-it
RUN git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
RUN chmod u+x ~/.bash_it/install.sh
RUN ~/.bash_it/install.sh -s

# Download dotfiles
RUN mkdir .config
RUN git clone https://github.com/marvinamari/.dotfiles.git
RUN rm .bashrc && cp -r .dotfiles/docker/.bashrc .bashrc
RUN cp -r .dotfiles/.alias .alias
RUN cp -r .dotfiles/nvim .config/nvim

# Install Packer Plugin Manager
RUN git clone https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

RUN nvim +PackerInstall +qall #>> /dev/null

# Workspace
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

# Set default user
USER dev


RUN source ~/.bashrc

CMD ["/bin/entrypoint.sh"]


