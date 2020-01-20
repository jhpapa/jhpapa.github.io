---
layout: post
title: Vim 설정하기
date: '2018-01-29 00:41'
updated: 2020-01-20 23:41:03 +0900
categories:
  - Editor
tags:
  - vi
  - vim
---

# Vim 설정하기
처음 vim을 사용할 때에 기본적으로 지원되지 않는 것들이 있습니다.
라인 넘버가 안보이는 경우 vim 안에서 `:set number`라고 입력하면 라인 넘버가 보이지만, vim을 종료하게 되면 해당 옵션이 유지되지 않습니다.
설정을 유지하기 위해선 설정파일에 필요한 옵션을 설정해줄 필요가 있습니다.

기본적으로 설정파일이라 숨김파일로 홈폴더 밑에 존재하며 파일의 위치는 `~/.vimrc` 입니다.
해당 위치에 존재하지 않는 경우는 동일한 파일명으로 생성해주면 됩니다.

on, off 가능한 옵션은 **toggle 명령어**를 사용할 수 있습니다.
toggle 명령어는 `set [옵션]!` 또는 `set inv[옵션]`로 사용합니다.
toggle 명령어를 사용하게 되면 현재 적용되고 있는 옵션의 반대 옵션을 적용시킵니다.

toggle을 이용하지 않고 옵션을 끄고 싶다면 반대 옵션을 사용하면 됩니다.
반대 옵션은 보통 `no[옵션]`으로 되어 있습니다. 예를 들어, `hlsearch`라는 옵션이 있을 때, 반대 옵션은 `nohlsearch`가 됩니다.
옵션을 줄여서 사용할 때도 동일한 방법으로 반대 옵션을 적용할 수 있습니다.

## 화면 설정

``` vim
syntax on " 형식별 구문 강조 표시
colorschme [scheme명] " 테마 적용.
set number " 라인 넘버 표시. (= nu)
set showcmd " 사용자가 입력한 명령어 표시
set showmatch " 현재 선택된 괄호의 쌍을 표시
set relativenumber " 커서를 기준으로 라인 넘버 표시. 커서 위치에 따라 바뀜. (= rnu)
set cursorline " 커서가 있는 라인을 강조 표시. (= cul)
set ruler " 커서 위치 표시. (= ru)
set laststatus=2 " 상태바 표시. (= ls) [0: 상태바 미표시 / 1: 2개 이상의 윈도우에서 표시 / 2: 항상 표시]
" 상태바 커스터마이징 %<item>으로 사용하며, \는 구분자로 공백을 넣을 경우는 구분자를 넣어줘야함.
set statusline=%F\ %y%m%r\ %=Line:\ %l/%L\ [%p%%]\ Col:%c\ Buf:%n
hi statusline ctermfg=White ctermbg=4 cterm=none "활성화된 상태바 배경색 및 폰트색 설정
hi statuslineNC ctermfg=White ctermbg=8 cterm=none " 윈도우가 2개 이상인 경우 비활성화된 윈도우의 배경색 및 폰트색 설정
set mouse=a " 마우스로 스크롤 및 리사이즈 가능. [n : Normal mode / v : Visual mode / i : Insert mode / a : All modes]
```

* 기본으로 제공되는 colorscheme는 Mac 기준 `/usr/share/vim/vim{version}/colors`에 위치하고 있습니다.
    * 여러가지 컬러는 [여기](https://vimcolors.com/)에서 다운로드받을 수 있습니다.
    * 다운로드 받은 scheme는 `~/.vim/colors/` 디렉토리(존재하지 않는 경우 생성)에 넣으면  적용할 수 있습니다.

## 검색 설정

``` vim
set hlsearch " 검색된 결과 강조 표시. (= hls)
set ignorecase " 검색시 대소문자를 구분하지 않음. (= ic)
set incsearch " 검색어를 입력할 때마다 일치하는 문자열을 강조해서 표시. (= is)
set smartcase " ignore 옵션이 켜져있더라도 검색어에 대문자가 있다면 정확히 일치하는 문자열을 찾음. (= scs)
```

## 들여쓰기 설정

``` vim
set autoindent " 새로운 라인이 추가될 때, 이전 라인의 들여쓰기에 자동으로 맞춤. (= ai)
set expandtab  " Tab을 Space로 변경. (= et)
set tabstop=4 " 탭으로 들여쓰기시 사용할 스페이스바 개수. (= ts)
set shiftwidth=4 " <<, >> 으로 들여쓰기시 사용할 스페이스바 개수. (= sw)
set softtabstop=4 " 스페이스바 n개를 하나의 탭으로 처리. (= sts)
" ex) 스페이스바 4개가 연속으로 있다면 백스페이스로 스페이스바를 지우면 스페이스바 4개를 하나의 탭으로 인식해 삭제.
filetype indent on " indent.vim 파일에 설정된 파일 형식별 들여쓰기 적용.
```

## 입력 설정

``` vim
set clipboard=unnamed " vim에서 복사한 내용이 클립보드에 저장
set backspace=eol,start,indent " 라인의 시작과 끝의 들여쓰기를 백스페이스로 지움.
set history=1000 " 편집한 내용 저장 개수 (되돌리기 제한 설정)
set paste " 다른 곳에서 복사한 내용을 붙여넣을 때, 자동 들여쓰기가 적용되는 것을 막아 복사한 내용을 들여쓰기없이 복사.
set pastetoggle=<F2> " paste 옵션이 적용되면 들여쓰기가 옵션이 제대로 작동하지 않기 때문에 toggle식으로 옵션을 키고 끌 수 있음.
```
clipboard 옵션은 vim에서 복사한 내용을 클립보드에 저장해 다른 어플리케이션에서도 사용할 수 있게 해줍니다.  
해당 옵션을 설정하면 OS별로 클립보드로 사용하는 레지스터에 값을 추가로 저장해줍니다.

옵션은 `unnamed`, `unnamedplus`(>= vim7.4) 두 개가 있으며 `unnamed`로 설정하면 `*`레지스터에 추가로 저장해주고, `unnamedplus`로 설정하면 `+` 레지스터에 추가로 저장됩니다.
해당 옵션을 설정하기 위해 OS별로 어떤 레지스터를 사용하는지 알아야 합니다.   
OS별 클립보드로 사용하는 레지스터는 아래와 같습니다.
* Windows : `+`레지스터 = `*`레지스터 (Windows에서 두 레지스터는 동일하게 사용)
* OSX : `*`레지스터
* Linux : `+`레지스터(Ctrl+C, Ctrl+V), `*`레지스터(drag, mouse button)

Windows와 OSX는 모두 하나의 클립보드를 이용하며, Windows에서는 `*`, `+` 두 레지스터 모두 클립보드로 사용됩니다.  Linux에서는 앞의 두 OS와 다르게 두 개의 클립보드가 있습니다. Ctrl+C, Ctrl+V를 사용하면 `+`레지스터를 이용하고(CLIPBOARD), 마우스로 드래그해서 선택하여 마우스로 버튼으로 복사할 때는 `*`레지스터를 사용합니다(PRIMARY).

OS별로 아래와 같이 설정하면 vim에서 복사한 내용을 다른 곳에서 Ctrl+C, Ctrl+V 를 이용해 복사할 수 있습니다.

> Windows, OSX : `set clipboard=unnamed`   
> Linux : `set clipboard=unnamedplus`

더 많은 옵션들이 있지만, 자주 쓸만한 옵션만 정리해보았습니다.
  

## 플러그인

vim에서 플러그인을 사용하려면 [vim-plug](https://github.com/junegunn/vim-plug)이라는 플러그인 매니저가 필요합니다.  
설치 방법 및 유용한 플러그인까지 알아보겠습니다.

### vim-plug 설치

터미널에서 아래의 명령어를 입력해 다운로드 받습니다.

``` shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### vimrc 설정

`.vimrc` 에 플러그인 매니저 설정 및 사용할 플러그인을 추가해야 합니다.

``` vim
" 플러그인 설정
" - ~/.vim/plugged 폴더에 플러그인이 설치됩니다.
call plug#begin('~/.vim/plugged')

" 필요한 플러그인 추가
" Plug 'github repository'
Plug 'scrooloose/nerdtree'

call plug#end()
```

### 플러그인 설치

설정이 끝나면 설정파일 저장 후, vim을 다시 켜거나 `:source %`를 입력해 설정 파일을 다시 로드해줍니다.  
명령모드에서 `:PlugInstall` 을 입력하면 설정 파일에 추가한 플러그인을 설치합니다.
![플러그인 설치 완료](/assets/images/post/vim_plugin_install_success.png)

### 플러그인 삭제

플러그인을 삭제하고 싶다면 **설정 파일에서 추가한 플러그인의 git repository를 삭제**하고 설정 파일을 다시 로드한 다음 `:PlugClean`을 입력해주면
설치할 때와 동일하게 좌측에 새창이 뜨면서 삭제할 플러그인이 보이고 삭제 여부를 물은 다음에 삭제 과정이 진행됩니다.
  

## 유용한 플러그인
다양한 플러그인에 대한 정보가 필요하다면 [Vim Awesome](https://vimawesome.com/)에서 찾을 수 있습니다.  
플러그인을 추가하려면 직접 git을 clone받아서 설정하거나, Vundle을 이용해 설정하는 방법이 있습니다. 위에서 Vundle을 설치했기 때문에 해당 설치 방법만 설명하겠습니다.

### The NERD Tree
[The NERD Tree](https://github.com/scrooloose/nerdtree)는 vim내에서 Tree 형태로 폴더 구조를 보여주는 플러그인입니다.  
먼저 `.vimrc` 에 **NERD Tree의 git repository를 추가**해 플러그인을 설치해줍니다.

``` vim
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree' " NERD Tree 추가
call plug#end()
```
NERD Tree 실행은 명령모드에서 `:NERDTree`라고 입력하면 좌측에 Tree view가 표시됩니다.

매번 명령어를 입력하기 귀찮기 때문에 단축키 설정을 해줍니다.   
설정 파일을 연다음에 아래와 같이 설정해줍니다. 전 단축키를 `\nt`로 설정하겠습니다.  
단축키 설정은 `map 단축키 명령어`로 합니다.

``` vim
let mapleader="\\"
map <Leader>nt <ESC>:NERDTree<CR>
```

이제 NERD Tree의 추가 옵션을 설정해보겠습니다.

``` vim
" Tree 아이콘 변경
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" 파일없이 vim만 틸 경우 자동으로 NERD Tree 실행.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 디렉토리를 vim으로 여는 경우 NERD Tree 실행.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
```

### Vim instant markdown (Markdown Preview)
[iamcco/markdown-preview.vim](https://github.com/iamcco/markdown-preview.vim)은 Vim에서 Markdown 파일을 편집할 때, 실시간으로 편집 내용을 브라우저를 통해 확인할 수 있는 플러그인입니다.

`vimrc`의 플러그인 매니저에 아래와 같은 플러그인 2개를 추가해주고 install합니다.

``` vim
Plugin 'iamcco/mathjax-support-for-mkdp'
Plugin 'iamcco/markdown-preview.vim'
```

사용 방법은 Markdown 파일을 열고 `:MarkdownPreview`를 입력하기만 하면 됩니다. 멈추고 싶다면 `MarkdownPreviewStop`을 입력하면 MarkdownPreview 브라우저가 종료됩니다. 

``` vim
let g:mkdp_path_to_chrome = ""
" Markdown Preview를 열고자하는 브라우저 경로 설정 (기본적으로 Chrome을 사용)
" 해당 옵션을 설정하게 된다면 g:mkdp_browserfunc는 무시됩니다.

let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
" callback vim function to open browser, the only param is the url to open

let g:mkdp_auto_start = 0
" set to 1, the vim will open the preview window once enter the markdown
" buffer

let g:mkdp_auto_open = 0
" set to 1, the vim will auto open preview window when you edit the
" markdown file

let g:mkdp_auto_close = 1
" set to 1, the vim will auto close current preview window when change
" from markdown buffer to another buffer

let g:mkdp_refresh_slow = 0
" set to 1, the vim will just refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor

let g:mkdp_command_for_global = 0
" set to 1, the MarkdownPreview command can be use for all files,
" by default it just can be use in markdown file
```

## My vimrc

제가 사용 중인 설정은 [여기](https://github.com/hongsii/dotfiles/blob/master/vim/vimrc.symlink)에서 확인할 수 있습니다.

--------------------------------

# 참고
* [Top 50 Vim Configuration Options](https://www.shortcutfoo.com/blog/top-50-vim-configuration-options/)
* [junegunn/vim-plug](https://github.com/junegunn/vim-plug)
