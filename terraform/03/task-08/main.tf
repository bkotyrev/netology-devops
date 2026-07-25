terraform {
  required_providers {}
  required_version = "~>1.12.0"
}

locals {
  webservers = [
    {
      name        = "web-1"
      platform_id = "standard-v3"

      network_interface = [
        {
          nat_ip_address = "158.160.1.10"
        }
      ]
    }
  ]
}

output "rendered_hosts" {
  value = templatefile("${path.module}/hosts.tftpl", {
    webservers = local.webservers
  })
}

