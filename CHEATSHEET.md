# Vim Cheatsheet

>Disclaimer: This cheatsheet is summarized from personal experience and other online tutorials. It should not be considered as an official advice.

## Shortcut

Whole file indentation
```vim
gg=G
```

Select the current word and apply it to a console command. e.g. echo
```vim
nnoremap <C-E> viwy:!echo <C-R>"<CR>
```

## Plugin Shortcut
```vim
<Leader> + d     # Use YDict to look up dictionary for translation
<Leader> + k     # Use Dasht to look up APIs
```

[Vim 101: QuickFix and Grep](https://medium.com/usevim/vim-101-quickfix-and-grep-c782cb65e524)
QuickFix commands:
```
:copen           # Open the quickfix window
:cn              # Go to the next location in the list
:cp              # Go to the previous location
:ccl OR :cclose  # Close the quickfix window
```

For QuickFix window in [ack.vim](https://github.com/mileszs/ack.vim):
```
?    a quick summary of these keys, repeat to close
o    to open (same as Enter)
O    to open and close the quickfix window
go   to preview file, open but maintain focus on ack.vim results
t    to open in new tab
T    to open in new tab without moving to it
h    to open in horizontal split
H    to open in horizontal split, keeping focus on the results
v    to open in vertical split
gv   to open in vertical split, keeping focus on the results
q    to close the quickfix window
```

