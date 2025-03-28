if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g fish_greeting
    starship init fish | source
    
    alias ls='ls --color'
    alias vim='nvim'
    alias c='clear'
    alias nv='nvim'
    alias z='zoxide'
end
