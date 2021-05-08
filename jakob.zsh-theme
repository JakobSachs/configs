PROMPT='[%T] %{$fg[blue]%}%n%{$reset_color%}:%{$fg[green]%}%2c%{$reset_color%}%(!.#.>) '

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"

RPROMPT='%F{202}$(git_prompt_info)%f'