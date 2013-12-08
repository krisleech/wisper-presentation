" Set the UI for presentation
function! Ui()
  :bufdo :set nocursorline
  :bufdo :set colorcolumn=
  :bufdo :set nu!
  :bufdo :set nu!
  :set laststatus=0
  :bufdo :set fillchars=fold:_
  :bufdo :set foldtext=v:folddashes.substitute('','','','g')
  :hi Folded ctermbg=235 ctermfg=235
  :set foldcolumn=1
  :bufdo :loadview
  :bufdo execute "normal! ggzj"
  :bufdo :hi NonText ctermfg=235 ctermbg=235
  :bufdo :call SyntaxRange#Include('@begin=ruby@', '@end=ruby@', 'ruby', 'NonText')
  :bufdo :call SyntaxRange#Include('@begin=haml@', '@end=haml@', 'haml', 'NonText')
  :buffer 1
endfunction

:call Ui()
