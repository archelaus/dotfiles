function autorm --wraps='sudo apt autoremove' --description 'alias autorm sudo apt autoremove'
  sudo apt autoremove $argv; 
end
