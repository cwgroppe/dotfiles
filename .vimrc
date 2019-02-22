" Vimrc coming at ya, don't fret brah.

" tab == 4 spaces, the only way

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

"Automatic install / double check of vim-plug 
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plug in baby - great muse tune

call plug#begin()

"file tree

Plug 'scrooloose/nerdtree'

" dope colorscheme

Plug 'drewtempelmeyer/palenight.vim'

" mini me you complete me 

Plug 'Valloric/YouCompleteMe'

" shows regex as your building it 

Plug 'osyo-manga/vim-over'

" db

Plug 'tpope/vim-dadbod'

" shell command to buffer

Plug 'JarrodCTaylor/vim-shell-executor'

" airline

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

" tmux integration

Plug 'benmills/vimux'

" markdown preview

Plug 'suan/vim-instant-markdown'

call plug#end()

" making things pretty

set background=dark
colorscheme palenight

" From the palenight's git repo:To provide the best user experience possible, 
" I recommend enabling true colors. To experience the blissfulness of your editor's true colors, 


" place this in your .vimrc or ~/.config/nvim/init.vim file
" I have no idea if i have termgui colors or not

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

" helping with highlighting - dont know if helping

let g:fzf_colors = { 'hl': ['fg', 'Comment'] }
let g:material_theme_style = 'palenight'
let g:material_terminal_italics = 1

" searchy searchy

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" turn off search highlighting with <CR> (carriage-return)

nnoremap <CR> :nohlsearch<CR><CR>

" y u so basic commands
set splitright
set wildmenu            " visual autocomplete for command menu
set ruler               " show line and column number of the cursor on right side of statusline
set lazyredraw          " redraw screen only when we need to
set showmatch           " highlight matching parentheses / brackets [{()}]

"F5/F3 add/deletes blank above,  and F4/F2 adds/deletes blank below
nnoremap <F2> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <F3> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <F4> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <F5> :set paste<CR>m`O<Esc>``:set nopaste<CR>

"some commands for autocomplete 

let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/global_extra_conf.py'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_confirm_extra_conf = 0

" toggle nerd tree

map <C-n> :NERDTreeToggle<CR>

" vim-over settings aka regFLEX
let g:over_enable_auto_nohlsearch = 1                     " enable the highlighting from the command line automatically
let g:over_enable_cmd_window = 1                          " enable the command line
let g:over_command_line_prompt = "> "                   " sets the |:OverCommandLine| prompt. Default >...<
let g:over#command_line#search#enable_incsearch = 1       " highlight :/ or :? searches
let g:over#command_line#search#enable_move_cursor = 1     "  highlight will follow the cursor on the :/ or :? command

" command line call

cabbrev %s OverCommandLine<cr>%s
cabbrev '<,'>s OverCommandLine<cr>'<,'>s

" more mappings
map <C-F> :set nu!<CR>

" airline 

let g:airline_theme='wombat'


" dadbod connections

let g:prod = 'eh'

let g:dev = 'eh'

" funcs and commands for dadbob to run in visual mode... took
" db_getvisualblock from dbext
 
command! -nargs=0 -range DBVisDev echo DB_getVisualDev()

function! DB_getVisualDev() range
    let save = @"
    " Mark the current line to return to
    let curline     = line("'<")
    let curcol      = virtcol("'<")

    silent normal gvy
    let vis_cmd = @"
    let @" = save

    " Return to previous location
    " Accounting for beginning of the line
    " call cursor(curline, curcol)
    execute 'DB g:dev ' vis_cmd
endfunction

command! -nargs=0 -range DBVisProd echo DB_getVisualBlock()

function! DB_getVisualBlock() range
    let save = @"
    " Mark the current line to return to
    let curline     = line("'<")
    let curcol      = virtcol("'<")

    silent normal gvy
    let vis_cmd = @"
    let @" = save

    " Return to previous location
    " Accounting for beginning of the line
    " call cursor(curline, curcol)
    execute 'DB g:prod ' vis_cmd
endfunction

