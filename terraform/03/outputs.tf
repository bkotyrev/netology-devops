# вариант с locals чуть короче циклов по двум массивам

locals {
  output_vms = concat(
    yandex_compute_instance.web,
    values(yandex_compute_instance.db)
  )
}

output "vms_info" {
  value = [
    for vm in local.output_vms : {
      name = vm.name
      id   = vm.id
      fqdn = vm.fqdn
    }
  ]
}

# output "vms_info" {
#   description = "VMs created with count and for_each"

#   value = concat(
#     [
#       for vm in yandex_compute_instance.web : {
#         name = vm.name
#         id   = vm.id
#         fqdn = vm.fqdn
#       }
#     ],
#     [
#       for vm in values(yandex_compute_instance.db) : {
#         name = vm.name
#         id   = vm.id
#         fqdn = vm.fqdn
#       }
#     ]
#   )
# }
