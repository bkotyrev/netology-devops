variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "subnet_id" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_hostname" {
  type = string
}

variable "vm_platform_id" {
  type = string
}

variable "vm_image_id" {
  type = string
}

variable "vm_boot_disk_name" {
  type = string
}

variable "vm_boot_disk_type" {
  type = string
}

variable "vm_boot_disk_size" {
  type = number
}

variable "vm_boot_disk_block_size" {
  type = number
}

variable "vm_boot_disk_auto_delete" {
  type = bool
}

variable "vm_network_interface_index" {
  type = number
}

variable "vm_nat" {
  type = bool
}

variable "vm_resources" {
  type = object({
    memory        = number
    cores         = number
    core_fraction = number
  })
}

variable "vm_preemptible" {
  type = bool
}

variable "vm_username" {
  type = string
}

variable "vm_ssh_public_key" {
  type = string
}

variable "vm_metadata_source" {
  type = string
}
