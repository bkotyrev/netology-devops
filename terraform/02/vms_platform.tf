variable "vm_name_prefix" {
  type    = string
  default = "netology"
}

variable "vm_name_platform" {
  type    = string
  default = "platform"
}

variable "vm_web_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "vm_web_role" {
  type    = string
  default = "web"
}

variable "vm_web_platform_id" {
  type    = string
  default = "standard-v4a"
}

variable "vm_web_preemptible" {
  type    = bool
  default = true
}

variable "vm_web_nat" {
  type    = bool
  default = true
}

# variable "vm_web_resources" {
#   type = object({
#     cores         = number
#     memory        = number
#     core_fraction = number
#   })
#
#   default = {
#     cores         = 2
#     memory        = 1
#     core_fraction = 20
#   }
# }

variable "vm_db_zone" {
  type    = string
  default = "ru-central1-b"
}

# variable "vm_db_image_family" {
#   type    = string
#   default = "ubuntu-2004-lts"
# }

variable "vm_db_role" {
  type    = string
  default = "db"
}

variable "vm_db_platform_id" {
  type    = string
  default = "standard-v4a"
}

variable "vm_db_preemptible" {
  type    = bool
  default = true
}

variable "vm_db_nat" {
  type    = bool
  default = true
}

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))

  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 20
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

# variable "vm_db_resources" {
#   type = object({
#     cores         = number
#     memory        = number
#     core_fraction = number
#   })
#
#   default = {
#     cores         = 2
#     memory        = 2
#     core_fraction = 20
#   }
# }

variable "metadata" {
  type        = map(string)
  description = "Common metadata for all VMs"
}
