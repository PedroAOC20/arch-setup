# ======================
# Variaveis de Ambiente
# =====================
export EDITOR="nvim"
export TERMINAL="ghostty"

#==========================
# Configs do terminal
#==========================

function hello_term
    fastfetch
end

if status is-interactive
    mise activate fish | source
else
    mise activate fish --shims | source
end

/home/pedro/.local/bin/mise activate fish | source
#==========================
# Inicializador do terminal 
#==========================

hello_term
starship init fish | source

#==========================
# Atalhos de comando  
#==========================

alias update="sudo pacman -Syu && yay -Syu"
