function dstop --wraps='docker stop `docker ps -aq`' --description 'alias dstop docker stop `docker ps -aq`'
  docker stop `docker ps -aq` $argv; 
end
