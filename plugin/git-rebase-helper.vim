" Git rebase helper for:
"   git rebase --interactive
"
"   L   - view commit log
"   p   - pick
"   e   - edit
"   f   - fixup
"   s   - squash
"   r   - reword
"   D   - delete
"   e   - exec
"   l   - label
"   t   - reset
"   m   - merge
"
"       Cornelius <cornelius.howl@gmail.com>

let g:vim_rebase_helper = 0

fun! RebaseLog()
  let line = getline('.')
  let hash = matchstr(line,'\(^\w\+\s\)\@<=\w*')
  vnew
  setlocal noswapfile  
  setlocal nobuflisted nowrap cursorline nonumber fdc=0
  setlocal buftype=nofile 
  setlocal bufhidden=wipe
  let output = system(printf('git log -p %s^1..%s', hash,hash ))
  silent put=output
  silent normal ggdd
  setlocal nomodifiable
  setfiletype git
endf

fun! RebaseAction(name)
  exec 's/^\w\+/'.a:name.'/'
endf

fun! g:InitGitRebase()
  let g:vim_rebase_helper = 1
  nmap <silent><buffer> p :cal RebaseAction('pick')<CR>
  nmap <silent><buffer> r :cal RebaseAction('reword')<CR>
  nmap <silent><buffer> e :cal RebaseAction('edit')<CR>
  nmap <silent><buffer> s :cal RebaseAction('squash')<CR>
  nmap <silent><buffer> f :cal RebaseAction('fixup')<CR>
  nmap <silent><buffer> x :cal RebaseAction('exec')<CR>
  nmap <silent><buffer> b :cal RebaseAction('break')<CR>
  nmap <silent><buffer> D :cal RebaseAction('drop')<CR>
  nmap <silent><buffer> l :cal RebaseAction('label')<CR>
  nmap <silent><buffer> t :cal RebaseAction('reset')<CR>
  nmap <silent><buffer> m :cal RebaseAction('merge')<CR>
  nmap <silent><buffer> L :cal RebaseLog()<CR>
  nmap <silent><buffer> <Esc> :call FiniGitRebase()<CR>
endf

fun! g:FiniGitRebase()
  if g:vim_rebase_helper
    let g:vim_rebase_helper = 0
    unmap <silent><buffer> p
    unmap <silent><buffer> r
    unmap <silent><buffer> e
    unmap <silent><buffer> s
    unmap <silent><buffer> f
    unmap <silent><buffer> x
    unmap <silent><buffer> b
    unmap <silent><buffer> D
    unmap <silent><buffer> l
    unmap <silent><buffer> t
    unmap <silent><buffer> m
    unmap <silent><buffer> L
  endif
endf

autocmd filetype gitrebase :cal g:InitGitRebase()
