export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/alias/default" ]]; then
  export PATH="$NVM_DIR/versions/node/$(<"$NVM_DIR/alias/default")/bin:$PATH"
fi
