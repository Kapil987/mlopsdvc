
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if [ -f '/c/Users/kkapil/AppData/Local/anaconda3/Scripts/conda.exe' ]; then
    eval "$('/c/Users/kkapil/AppData/Local/anaconda3/Scripts/conda.exe' 'shell.bash' 'hook')"
fi
# <<< conda initialize <<<
## eza
export LS_COLORS="$LS_COLORS:*.md=00;95:" # Lighter magenta/pink
#alias ls='eza --icons --group-directories-first' 
#alias la='eza -la --icons --group-directories-first' 
#alias lrt='eza -l --sort=modified --reverse --icons --group-directories-first'

## startship
eval "$(starship init bash)"

## zoxide
eval "$(zoxide init bash)"
alias z='zoxide'
