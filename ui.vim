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
  :bufdo :hi NonText ctermfg=235 ctermbg=235
  :bufdo :call SyntaxRange#Include('@begin=ruby@', '@end=ruby@', 'ruby', 'NonText')
  :bufdo :call SyntaxRange#Include('@begin=haml@', '@end=haml@', 'haml', 'NonText')
  :bufdo :GitGutterDisable
  :bufdo execute "normal! gg"
  :buffer 1
  :map r zjzozz
  " :map R Gzk[zzc
  :map Q qa!
endfunction

:call Ui()
