function aptrm --wraps='sudo apt remove' --description 'alias aptrm sudo apt remove'
  sudo apt remove $argv; 
end
