" Set the UI for editting presentation
function! Ui()
  :set foldcolumn=1
  :bufdo :loadview
  :bufdo execute "normal! gg"
  :bufdo :call SyntaxRange#Include('@begin=ruby@', '@end=ruby@', 'ruby', 'NonText')
  :bufdo :call SyntaxRange#Include('@begin=haml@', '@end=haml@', 'haml', 'NonText')
  :bufdo :GitGutterDisable
  :map r zjzo
  :buffer 1
  " :map :w :mkview :w
endfunction

:call Ui()
