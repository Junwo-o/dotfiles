if command -v python3 >/dev/null 2>&1; then
    alias python='python3'
    alias pip='pip3'
fi

cat << "EOF"
EOF

alias kickstart='NVIM_APPNAME=kickstart nvim'
alias lazyvim='NVIM_APPNAME=lazyvim nvim'

# vim motions within terminal (bash equivalent)
set -o vi
