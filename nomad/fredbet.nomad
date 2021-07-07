job "fredbet" {
  datacenters = ["dc1"]
  type = "service"

  group "fredbet-group" {
    network {
      # Dynamic ports
      port "foo" {}
      port "bar" {}
      # Mapped ports
      port "http"  { to = 80 }
      port "https" { to = 443 }
      # Static ports
      port "lb" { static = 8080 }
    }

    service {
      name = "fredbet"
      tags = ["global", "fredbet"]
      port = "http"

//      check {
//        type = "http"
//        name = "http-health"
//        path = "/actuator/health"
//        interval = "10s"
//        timeout = "3s"
//      }
    }

    task "fredbet-task" {
      driver = "docker"

      config {
        image = "fred4jupiter/fredbet:latest"
        ports = ["lb"]
      }

      resources {
        cpu = 500
        memory = 512
      }
    }
  }
}
