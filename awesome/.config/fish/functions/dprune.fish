function dprune --wraps='docker image prune' --description 'alias dprune docker image prune'
  docker image prune $argv; 
end
