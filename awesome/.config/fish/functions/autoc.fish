function autoc --wraps='sudo apt autoclean' --description 'alias autoc sudo apt autoclean'
  sudo apt autoclean $argv; 
end
