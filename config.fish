if set -q ZELLIJ
else
    zellij
end

source ~/.config/fish/themes/tokyonight_day.fish

# aliases
function gcm --wraps='git commit -m' --description 'alias gcm git commit -m'
  git commit -m $argv        
end

function gt --wraps='git status' --description 'alias gt git status'
  git status $argv        
end

function gp --wraps='git push' --description 'alias gp git push'
  git push
end
