function openports --wraps='ss --all --numeric --processes --ipv4 --ipv6' --description 'alias openports ss --all --numeric --processes --ipv4 --ipv6'
  ss --all --numeric --processes --ipv4 --ipv6 $argv; 
end
