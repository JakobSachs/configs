if not set -q ZELLIJ
    if test -t 1
        # Don't start zellij if we're in an SSH session
        if not set -q SSH_CONNECTION
            exec zellij
        end
    end
end

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



# less pager
set -x LESS "-RFiMg"

# opencode
fish_add_path /home/jakob/.opencode/bin


 starship init fish | source
