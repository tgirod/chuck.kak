# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.]ck %{
  set-option buffer filetype chuck
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=chuck %{
  require-module chuck
  hook window InsertChar \n -group chuck-indent chuck-indent-on-new-line
  hook -once -always window WinSetOption filetype=.* %{ remove-hooks window chuck-.+ }
}

hook -group chuck-highlight global WinSetOption filetype=chuck %{
  add-highlighter window/chuck ref chuck
  hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/chuck }
}

provide-module chuck %{
  add-highlighter shared/chuck regions
  add-highlighter shared/chuck/code default-region group

	add-highlighter shared/chuck/print region '<<<' '>>>' fill string
	add-highlighter shared/chuck/string region '"' '"' fill string

  add-highlighter shared/chuck/comment_line	region '//' '$' fill comment
  add-highlighter shared/chuck/comment_block region '/\*' '\*/' fill comment

	add-highlighter shared/chuck/code/keywords regex \b(fun|function|return|const|new|now|pi|me|samp|ms|second|minute|hour|day|week|repeat|break|continue|class|extends|public|private|static|pure|this|spork|cherr|chout)\b 0:keyword

	add-highlighter shared/chuck/code/types regex \b(int|float|time|dur|void|string|array|ugen|complex|polar|Object|Event|UGen)\b 0:type

	add-highlighter shared/chuck/code/operators regex \B(=>|@=>|=\^)\B 0:operator
}

define-command -hidden chuck-indent-on-new-line %{
  evaluate-commands -draft -itersel %{
    # preserve previous line indent
    try %{ execute-keys -draft <semicolon> K <a-&> }
    # indent after :
    try %{ execute-keys -draft <space> k x <a-k> :$ <ret> j <a-gt> }
  }
}

define-command -docstring "chuck-start: starts the chuck server" chuck-start %{
  tmux-repl-vertical chuck --loop
  tmux-focus
}

