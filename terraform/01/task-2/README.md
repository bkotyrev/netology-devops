# Задание 2

## 1. Создание VM

```bash
cd infra
terraform init
terraform apply
terraform output vm_external_ip
terraform output docker_host
```

## 2. Запуск MySQL

```bash
cd mysql
terraform init
terraform apply
terraform output mysql_container_name
terraform output mysql_credentials
```

