#!/bin/bash

# Cập nhật gói phần mềm và cài đặt NeoVim
sudo apt update && sudo apt install -y neovim

# Cài đặt vim-plug, quản lý plugin cho NeoVim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Tạo thư mục cấu hình cho NeoVim và file init.vim
mkdir -p ~/.config/nvim
echo "call plug#begin('~/.vim/plugged')

\" Cài đặt các plugin cần thiết
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

\" Cấu hình cơ bản
set number
syntax on
colorscheme desert

\" Để NeoVim tự động cài đặt các plugin khi khởi động lần đầu
autocmd VimEnter * PlugInstall | q" > ~/.config/nvim/init.vim

echo "Cài đặt NeoVim và các plugin đã hoàn tất."
