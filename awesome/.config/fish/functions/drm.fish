function drm --wraps='docker rm `docker ps -aq`' --description 'alias drm docker rm `docker ps -aq`'
  docker rm `docker ps -aq` $argv; 
end
