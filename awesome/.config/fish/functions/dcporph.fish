function dcporph --wraps='docker-compose -f ~/.config/docker-compose.yml up -d --remove-orphans' --description 'alias dcporph docker-compose -f ~/.config/docker-compose.yml up -d --remove-orphans'
  docker-compose -f ~/.config/docker-compose.yml up -d --remove-orphans $argv; 
end
