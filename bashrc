if command -v python3 >/dev/null 2>&1; then
    alias python='python3'
    alias pip='pip3'
fi

cat << "EOF"
EOF

alias kvim='NVIM_APPNAME=kickstart nvim'
alias lvim='NVIM_APPNAME=lazyvim nvim'

# vim motions within terminal (bash equivalent)
set -o vi
