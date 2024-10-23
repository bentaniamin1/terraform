Check docker deamon  port : 

1) fichier daemon.json dans etc/docker

 {
  "hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:2375"]
}

2) sudo systemctl restart docker

3) netstat -tuln | grep 2375
