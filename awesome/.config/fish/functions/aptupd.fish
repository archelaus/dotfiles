function aptupd --wraps='sudo apt update' --description 'alias aptupd sudo apt update'
  sudo apt update $argv; 
end
