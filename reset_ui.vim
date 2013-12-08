function! ResetPres()
  :bufdo execute "normal! zE"
  :buffer 1
endfunction

:call ResetPres()
