"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 一般设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设定默认解码
set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936

" 不要使用vi的键盘模式，而是vim自己的
set nocompatible

" history文件中需要记录的行数
set history=100

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" 与windows共享剪贴板
set clipboard+=unnamed

" 侦测文件类型
filetype on

" 载入文件类型插件
filetype plugin on

" 为特定文件类型载入相关缩进文件
filetype indent on

" 保存全局变量
set viminfo+=!

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" 语法高亮
syntax on

" 高亮字符，让其不受100列限制
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\%101v.*'

" 状态行颜色
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White

set nu

"
set t_Co=256
set background=dark
colorscheme torte

"设定复制粘贴的映射
vnoremap <C-c> "*y

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文件设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 不要备份文件（根据自己需要取舍）
set nobackup

" 不要生成swap文件，当buffer被丢弃的时候隐藏它
setlocal noswapfile
set bufhidden=hide

" 字符间插入的像素行数目
set linespace=0

" 增强模式中的命令行自动完成操作
set wildmenu

" 在状态行上显示光标所在位置的行号和列号
set ruler
set rulerformat=%20(%2*%<%f%=\ %m%r\ %3l\ %c\ %p%%%)

" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2

" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2

" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=atI

" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0

" 不让vim发出讨厌的滴滴声
set noerrorbells

" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索和匹配
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 高亮显示匹配的括号
set showmatch

" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5

" 在搜索的时候忽略大小写
set ignorecase

" 不要高亮被搜索的句子（phrases）
set nohlsearch

" 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索）
set incsearch

" 输入:set list命令是应该显示些啥？
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$

" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3

" 不要闪烁
set novisualbell

" 我的状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

" 总是显示状态行
set laststatus=2

set tags=tags
set tags+=./tags "add current directory's generated tags file

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 文本格式和排版
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自动格式化
set formatoptions=tcrqn

" 继承前一行的缩进方式，特别适用于多行注释
set autoindent

" 为C程序提供自动缩进
set smartindent

" 使用C样式的缩进
" set cindent

" 制表符为4
set tabstop=4

" 统一缩进为4
" set softtabstop=4
set shiftwidth=4

" 不要用空格代替制表符
set expandtab
" 如果改成set noexpandtab就是不用四个空格代替一个table

" 不要换行
set nowrap

" 在行和段开始处使用制表符
set smarttab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags的设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd = '/usr/bin/ctags'

" 按照名称排序
let Tlist_Sort_Type = "name"

" 在右侧显示窗口
let Tlist_Use_Right_Window = 1

" 压缩方式
let Tlist_Compart_Format = 1

" 如果只有一个buffer，kill窗口也kill掉buffer
let Tlist_Exist_OnlyWindow = 1

" 不要关闭其他文件的tags
let Tlist_File_Fold_Auto_Close = 0

" 不要显示折叠树
let Tlist_Enable_Fold_Column = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUG Manage ---kevin 2018-10
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"插件1:漂亮的状态栏"
Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline-themes'

"插件2:tagbar"
Plug  'majutsushi/tagbar'

"插件3:nodetree"
Plug  'scrooloose/nerdtree'

"插件4:ctrlp"
Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'

"插件5:ack.vim"
Plug 'mileszs/ack.vim'

"插件6:ctrlsf.vim"
Plug 'dyng/ctrlsf.vim'

call plug#end()
"=============================================================================================="
"=================================以下为插件配置================================================"
"********************************************************************"
"插件1配置 ariline-------

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
set guifont=Sauce\ Code\ Powerline\ Regular

"********************************************************************"
"插件2配置  tagbar-----

let g:tarbar_ctags_bin='ctags'  " ctags程序的路径
let g:tagbar_width=30   "窗口宽度设置为 30
let g:tagbar_left=1   "设置在vim左边显示
let g:tagbar_map_openfold="zv"  "按zv组合键打开标签，默认zc关闭标签

" 如果是c语言的程序的话，tagbar自动开启
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()

" 我设置F2为打开或者关闭的快捷键，根据你的习惯更改
nnoremap <silent> <F2> :TagbarToggle<CR>

"********************************************************************"
"插件3配置 nerdtree插件，
let NERDTreeWinPos='right'  "设置在vim右侧显示
let NERDTreeWinSize=30   "设置宽度为30
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" 我设置F3为打开或者关闭的快捷键，你可以自定义
map <F3> : NERDTreeToggle<CR>
"********************************************************************"
"插件4配置 ctrlp
let g:ctrlp_map =  '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

"********************************************************************"
"插件5配置 ack.vim
"ack
"<Leader>c进行搜索，同时不自动打开第一个匹配的文件"
map <F4> :Ack<Space> 
"调用ag进行搜索
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
"高亮搜索关键词
let g:ackhighlight = 1
"修改快速预览窗口高度为15
let g:ack_qhandler = "botright copen 15"
"在QuickFix窗口使用快捷键以后，自动关闭QuickFix窗口
let g:ack_autoclose = 1
"使用ack的空白搜索，即不添加任何参数时对光标下的单词进行搜索，默认值为1，表示开启，置0以后使用空白搜索将返回错误信息
let g:ack_use_cword_for_empty_search = 1
"部分功能受限，但对于大项目搜索速度较慢时可以尝试开启
"let g:ack_use_dispatch = 1
"********************************************************************"
"插件6配置 ctrlsf.vim
map <C-F> :CtrlSF<space>
"=================================以上为插件配置================================================"
"=============================================================================================="
