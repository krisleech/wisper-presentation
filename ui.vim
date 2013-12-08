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
  :buffer 1
endfunction

:call Ui()
