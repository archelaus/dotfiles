function aptupg --wraps='sudo apt upgrade' --description 'alias aptupg sudo apt upgrade'
  sudo apt upgrade $argv; 
end
