function dcp --wraps='docker-compose -f ~/.config/docker-compose.yml' --description 'alias dcp docker-compose -f ~/.config/docker-compose.yml'
  docker-compose -f ~/.config/docker-compose.yml $argv; 
end
