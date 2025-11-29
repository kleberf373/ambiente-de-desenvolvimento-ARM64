FROM arm64v8/debian:bookworm-slim

RUN echo "deb http://deb.debian.org/debian bookworm-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    vim \
    pkg-config \
    libdrm-dev \
    libxtst-dev \
    libsdl2-dev \
    libsdl2-mixer-dev \
    libsdl2-image-dev \
    libglut-dev \
    mesa-vulkan-drivers \
    mesa-common-dev \
    libegl1-mesa-dev \
    libvulkan-dev \
    libgles2-mesa-dev && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/libsdl-org/SDL.git
RUN git clone https://github.com/libsdl-org/SDL_mixer.git
RUN git clone https://github.com/libsdl-org/SDL_image.git

RUN cd SDL && cmake . && make && make install 
RUN cd ../SDL_mixer && cmake . && make && make install 
RUN cd ../SDL_image && cmake . && make && make install

RUN cd .. && rm -rf SDL/ SDL_mixer/ SDL_image/

RUN apt-get update && apt-get install -y curl

RUN curl -fLo /root/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN echo "set nocompatible" >> /root/.vimrc && \
    echo "call plug#begin('~/.vim/plugged')" >> /root/.vimrc && \
    echo "Plug 'preservim/NERDTree'" >> /root/.vimrc && \
    echo "Plug 'tpope/vim-sensible'" >> /root/.vimrc && \
    echo "Plug 'egberts/vim-syntax-bind-named'" >> /root/.vimrc && \
    echo "Plug 'itchyny/lightline.vim'" >> /root/.vimrc && \
    echo "Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }" >> /root/.vimrc && \
    echo "Plug 'junegunn/fzf.vim'" >> /root/.vimrc && \
    echo "Plug 'mattn/emmet-vim'" >> /root/.vimrc && \
    echo "Plug 'dense-analysis/ale'" >> /root/.vimrc && \
    echo "call plug#end()" >> /root/.vimrc

RUN echo "nnoremap <leader>n :NERDTreeFocus<CR>" >> /root/.vimrc && \
    echo "nnoremap <C-n> :NERDTree<CR>" >> /root/.vimrc && \
    echo "nnoremap <C-t> :NERDTreeToggle<CR>" >> /root/.vimrc && \
    echo "nnoremap <C-f> :NERDTreeFind<CR>" >> /root/.vimrc && \
    echo "map <C-o> :NERDTreeToggle<CR>" >> /root/.vimrc

RUN vim -es -u /root/.vimrc -i NONE -c "PlugInstall" -c "qa"

WORKDIR /app

COPY . .

CMD ["/bin/bash"]
