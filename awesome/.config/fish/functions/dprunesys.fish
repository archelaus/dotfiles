function dprunesys --wraps='docker system prune --all' --description 'alias dprunesys docker system prune --all'
  docker system prune --all $argv; 
end
