" Set the UI for editting presentation
function! Ui()
  :set foldcolumn=1
  :bufdo :loadview
  :bufdo execute "normal! ggzj"
  :bufdo :call SyntaxRange#Include('@begin=ruby@', '@end=ruby@', 'ruby', 'NonText')
  :bufdo :call SyntaxRange#Include('@begin=haml@', '@end=haml@', 'haml', 'NonText')
  :buffer 1
endfunction

:call Ui()
