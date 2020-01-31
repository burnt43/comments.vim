function! comments#AddCommentOperator(type)
  if has_key(g:comments_filetype_to_comment_char, &filetype)
    " determine what is the leftmost non-whitespace character in the
    " entire selection
    if a:type ==# 'V'
      let start_line        = line("'<")
      let end_line          = line("'>")
      let replacement_range = "'<,'>"
    elseif a:type ==# 'line'
      let start_line        = line("'[")
      let end_line          = line("']")
      let replacement_range = "'[,']"
    endif

    let current_line = start_line
    let min_column   = 999

    while current_line <= end_line
      let match_column_number = matchstrpos(getline(current_line), '\v^\s*(\w)')[2]

      if match_column_number !=# -1 && match_column_number < min_column
        let min_column = match_column_number
      endif

      let current_line += 1
    endwhile

    " insert the comment character
    execute 'normal! :' . replacement_range . 's/\v%' . min_column . 'c/' . g:comments_filetype_to_comment_char[&filetype] . ' /g' . "\<cr>"
  endif
endfunction

function! comments#RemoveCommentOperator(type)
  if has_key(g:comments_filetype_to_comment_char, &filetype)
    if a:type ==# 'V'
      let replacement_range = "'<,'>"
    elseif a:type ==# 'line'
      let replacement_range = "'[,']"
    endif

    " remove the comment character
    execute 'normal! :' . replacement_range . 's/\v^(\s*)' . g:comments_filetype_to_comment_char[&filetype] . ' /\1/g' . "\<cr>"
  endif
endfunction
