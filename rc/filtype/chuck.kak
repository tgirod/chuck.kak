hook global BufCreate .*[.]ck %{
  set-option buffer filetype chuck
}

hook global WinSetOption filetype=chuck ${
	require-module chuck
}

provide-module chuck %{
  add-highlighter shared/chuck regions
  add-highlighter shared/chuck/code default-region group

  add-highlighter shared/chuck/comment_line	region '//' '$' fill comment
  add-highlighter shared/chuck/comment_region region '/\*' '\*/' comment
}
