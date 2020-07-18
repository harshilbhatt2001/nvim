let g:coc_global_extenstions = [
    \ 'coc-snippets',
    \ 'coc-pairs',
    \ 'coc-yaml',
    \ 'coc-python',
    \ 'coc-prettier',
    \ 'coc-explorer',
    \ 'coc-vimlsp',
    \ 'coc-xml',
    \ 'coc-json',
    \ 'coc-clangd',
    \ 'coc-marketplace',
    \ ]

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current 
" position. Coc only does snippet and additional edit to confirm
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo Code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol rename
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s)
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" provide custom statusline: lightline.vim, airline-vim
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" " Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait <>space>o  :<C-u>CocList outlinecr><
"  Search workspace symbols.
"  nnoremap <"silent>nowait>< <space>s  :<C-u>CocList -I symbols<cr>
"  " Do default action for next item.
"  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"  " Do default action for previous item.
"  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"  " Resume latest coc list.
"  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Explorer
let g:coc_explorer_global_presets = { 
            \   'floating': { 
            \      'position': 'floating', 
            \   }, 
            \   'floatingLeftside': { 
            \      'position': 'floating', 
            \      'floating-position': 'left-center', 
            \      'floating-width': 30, 
            \   }, 
            \   'floatingRightside': { 
            \      'position': 'floating', 
            \      'floating-position': 'right-center', 
            \      'floating-width': 30, 
            \   }, 
            \   'simplify': { 
            \     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]' 
            \   }   
            \ }

nmap <space>e :CocCommand explorer<CR>
nmap <space>f :CocCommand explorer --preset floating<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" Snippets
" Use <C-l> for trigger snippet expand
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet. 
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim 
let g:coc_snippet_next = '<c-j>' 
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim 
let g:coc_snippet_prev ='<c-k>' 
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)


