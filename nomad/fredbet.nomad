job "fredbet" {
  datacenters = ["dc1"]
  type = "service"

  group "fredbet-group" {
    network {
      port "http" {
        to = 8080
      }
    }

    service {
      name = "fredbet"
      tags = ["global", "fredbet"]
      port = "http"
    }

    task "fredbet-task" {
      driver = "docker"

      config {
        image = "fred4jupiter/fredbet:latest"
        ports = ["http"]
      }

      resources {
        cpu = 500
        memory = 512
      }
    }
  }
}
