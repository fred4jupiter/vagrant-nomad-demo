datacenter = "dc1"
data_dir = "/opt/consul"

client_addr = "192.168.56.110"

ui_config{
  enabled = true
}

server = true

bind_addr = "0.0.0.0" # Listen on all IPv4

advertise_addr = "192.168.56.110"

bootstrap_expect=1