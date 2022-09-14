PROMPT='[%T] %{$fg[cyan]%}%n%{$reset_color%}: %2c%{$reset_color%}%(!.#.>) '

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"

RPROMPT='%F{red}$(git_prompt_info)%f'
