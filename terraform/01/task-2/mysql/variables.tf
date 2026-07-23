variable "docker_host" {
  type        = string
  description = "Remote Docker Engine endpoint from the infra module output, for example ssh://kbe@1.2.3.4"
}

variable "mysql_image" {
  type    = string
  default = "mysql:8"
}

variable "mysql_database" {
  type    = string
  default = "wordpress"
}

variable "mysql_user" {
  type    = string
  default = "wordpress"
}

variable "mysql_root_host" {
  type    = string
  default = "%"
}

variable "mysql_bind_ip" {
  type    = string
  default = "127.0.0.1"
}

variable "mysql_port" {
  type    = number
  default = 3306
}
