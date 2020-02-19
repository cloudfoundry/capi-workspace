cat <<-EOF > $HOME/.inputrc
"\e[A": history-search-backward
"\e[B": history-search-forward
\$if Bash
  Space: magic-space
\$endif
set completion-ignore-case on
set visible-stats on
set show-all-if-ambiguous on
EOF
