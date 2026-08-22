# 08-ansible-04-role

Роли Vector и LightHouse вынесены в отдельные Git-репозитории: `git@github.com:bkotyrev/vector-role.git` и `git@github.com:bkotyrev/lighthouse-role.git`. 

Роль ClickHouse устанавливается из внешнего публичного репозитория.

## Установка зависимостей

```bash
ansible-galaxy install -r requirements.yml --roles-path .ansible/roles
```

## Запуск

Перед запуском перейти в каталог задания:

```bash
cd /mnt/c/Users/b.kotyrev/Desktop/Learning/netology-devops/ansible/08-ansible-04-role
export ANSIBLE_CONFIG="$PWD/ansible.cfg"
```

Полный запуск на inventory:

```bash
ansible-playbook -i inventory/prod.yml site.yml
```

Используется `inventory/localhost.yml`:

```bash
ansible-playbook -i inventory/localhost.yml site.yml --check --diff
```

## Роли и теги

| Роль | Назначение | Теги |
| --- | --- | --- |
| `clickhouse` | Установка и настройка ClickHouse через внешнюю роль | `clickhouse` |
| `vector` | Установка Vector и размещение `vector.yaml` | `vector` |
| `lighthouse` | Установка LightHouse, Nginx и виртуального хоста | `lighthouse`, `nginx` |

Примеры запуска отдельных частей:

```bash
ansible-playbook -i inventory/localhost.yml site.yml --tags vector --check
ansible-playbook -i inventory/localhost.yml site.yml --tags lighthouse,nginx --check
```

## Переменные

Переменные Vector описаны в репозитории `vector-role`, файл `defaults/main.yml`:

- `vector_version` — версия пакета;
- `vector_deb_url` и `vector_deb_path` — источник и временный путь пакета;
- `vector_config_path` — путь конфигурации;
- `vector_data_dir`, `vector_sources`, `vector_sinks` — параметры конфигурации Vector.

Переменные LightHouse описаны в репозитории `lighthouse-role`, файл `defaults/main.yml`:

- `lighthouse_archive_url` и `lighthouse_archive_path` — источник и временный путь архива;
- `lighthouse_document_root` — каталог статических файлов;
- `lighthouse_nginx_site_path` и `lighthouse_nginx_link_path` — пути конфигурации Nginx;
- `lighthouse_nginx_server_name` и `lighthouse_nginx_listen_port` — параметры виртуального хоста.

Обе роли имеют семантическую версию `1.0.0`, зафиксированную Git-тегами в соответствующих репозиториях.

## Локальная проверка

Основные команды проверки:

```bash
ansible-galaxy install -r requirements.yml --roles-path .ansible/roles
ansible-playbook -i inventory/localhost.yml site.yml --syntax-check
ansible-lint site.yml
ansible-playbook -i inventory/localhost.yml site.yml --check --diff
```

