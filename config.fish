# Path to Oh My Fish install.
set -gx OMF_PATH "/home/aram/.local/share/omf"
set -gx TERM "xterm-256color"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/home/aram/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

abbr -a vi vim
alias prettyjson "node /home/aram/scripts/pretty-json.js"

function nvm
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

# gcloud
set -gx GOOGLE_APPLICATION_CREDENTIALS "/home/aram/Documents/Penny-Royalty-b411b8f7c470.json"
