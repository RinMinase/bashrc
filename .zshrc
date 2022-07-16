export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# ==========================================
# Add terminal colors to prompt (not needed)
# ------------------------------------------

# add colors
# autoload -U colors && colors
# PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

# ==========================================


# ==========================================
# Add conda intialization
# ------------------------------------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ==========================================


# ==========================================
# Fixes pasting urls in terminal
# ------------------------------------------
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# ==========================================


# ==========================================
# Add git branch to zsh
# Modify prompt colors and prompt text
# ------------------------------------------
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b) '

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST

# <green>user<blue>@machine <orange>path <red>branch %
# PROMPT='%F{78}%n%F{111}@%m %F{11}${PWD/#$HOME/~} %F{9}${vcs_info_msg_0_}%{%f%}%% '

# <green>user<blue>@machine <orange>~/.../three/sub-paths/only <red>branch %
PROMPT='%F{78}%n%F{111}@%m %F{172}%(5~|%-1~/…/%3~|%4~) %F{124}${vcs_info_msg_0_}%{%f%}%% '


# ==========================================


# ==========================================
# Autocomplete double dots on tab
# ------------------------------------------

function dotcomplete() {
  if [[ $BUFFER =~ '(^| |\/)\.\.'$ ]]; then
    BUFFER="$BUFFER/"
    CURSOR=${#BUFFER}
    zle list-choices
  else
    zle expand-or-complete
  fi
}

bindkey '^I' dotcomplete
zle -N dotcomplete

# ==========================================


# ==========================================
# Aliases
# ------------------------------------------

alias refresh='source ~/.zshrc'
alias rebash='source ~/.zshrc'
alias la='ls -la'
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dce='docker-compose exec'
alias dcr='docker-compose run --rm'
alias dcb='docker-compose build'
alias yt='yt-dlp'
alias termcolors='for code in {000..255}; do print -P -- "$code: %F{$code}Color%f"; done'
alias nvm-lts='nvm install "lts/*" --reinstall-packages-from=current; nvm cache clear'

# ==========================================
