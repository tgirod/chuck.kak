# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*[.]ck %{
  set-option buffer filetype chuck
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=chuck %{
    require-module chuck

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

	add-highlighter shared/chuck/code/operators regex \b(=>|@=>|=\^)\b 0:operator
}

