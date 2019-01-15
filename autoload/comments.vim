function! comments#AddCommentOperator(type)
  if has_key(g:comments_filetype_to_comment_char, &filetype)
    if a:type ==# 'V'
      execute "normal! :'<,'>" . 's/^/'. g:comments_filetype_to_comment_char[&filetype] . ' /g' . "\<cr>"
    elseif a:type ==# 'line'
      execute "normal! :'[,']" . 's/^/'. g:comments_filetype_to_comment_char[&filetype] . ' /g' . "\<cr>"
    endif
  endif
endfunction

function! comments#RemoveCommentOperator(type)
  if has_key(g:comments_filetype_to_comment_char, &filetype)
    if a:type ==# 'V'
      execute "normal! :'<,'>" . 's/^'. g:comments_filetype_to_comment_char[&filetype] . ' //g' . "\<cr>"
    elseif a:type ==# 'line'
      execute "normal! :'[,']" . 's/^'. g:comments_filetype_to_comment_char[&filetype] . ' //g' . "\<cr>"
    endif
  endif
endfunction
