" Set the UI for editting presentation
function! LoadEditUi()
  :set foldcolumn=1
  :bufdo :loadview
  :bufdo :call SyntaxRange#Include('@begin=ruby@', '@end=ruby@', 'ruby', 'NonText')
  :bufdo :call SyntaxRange#Include('@begin=haml@', '@end=haml@', 'haml', 'NonText')
  :bufdo :GitGutterDisable
  :buffer 1
endfunction

" Set the UI for viewing presentation
function! Ui()
  :call LoadEditUi()
  :bufdo :set nocursorline
  :bufdo :set colorcolumn=
  :bufdo :set nu!
  :bufdo :set nu!
  :set laststatus=0
  :bufdo :set fillchars=fold:_
  :bufdo :set foldtext=v:folddashes.substitute('','','','g')
  :hi Folded ctermbg=235 ctermfg=235
  :bufdo :hi NonText ctermfg=235 ctermbg=235
  :buffer 1
endfunction

" Reveal the next fold
:map r zjzo

" Quit presenation without saving
:map Q qa!

" write buffer and save view (folds)
:map ,w :w<CR>:mkview<CR>

" Move cursor to first line
:bufdo execute "normal! gg"

" Switch to first slide/buffer
:buffer 1
