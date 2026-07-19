locals {
  vm_web_name = "${var.vm_name_prefix}-${var.vpc_name}-${var.vm_name_platform}-${var.vm_web_role}-1"
  vm_db_name  = "${var.vm_name_prefix}-${var.vpc_name}-${var.vm_name_platform}-${var.vm_db_role}-1"
}
