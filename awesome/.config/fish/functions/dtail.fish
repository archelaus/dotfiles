function dtail --wraps='docker logs -tf --tail=50 ' --description 'alias dtail docker logs -tf --tail=50 '
  docker logs -tf --tail=50  $argv; 
end
